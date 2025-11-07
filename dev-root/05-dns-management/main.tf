terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "your-tfe-organization"
    workspaces {
      name = "dev-05-dns-management"
    }
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.45"
    }
  }
}

locals {
  environment = "dev"
}

# Read outputs from previous stages
data "terraform_remote_state" "project_setup" {
  backend = "remote"
  config = {
    workspace = "dev-01-project-setup"
  }
}

data "terraform_remote_state" "networking_core" {
  backend = "remote"
  config = {
    workspace = "dev-02-networking-core"
  }
}

data "terraform_remote_state" "networking_dmz" {
  backend = "remote"
  config = {
    workspace = "dev-03-networking-dmz"
  }
}

# Create DNS Zones
module "dns_zones" {
  source = "../../modules/gcp-dns-zone"
  
  for_each = var.dns_zones
  
  project_id  = each.value.project_id
  zone_name   = each.value.zone_name
  dns_suffix  = each.value.dns_suffix
  description = each.value.description
  visibility  = each.value.visibility
  
  private_visibility_config_networks = [
    for network in each.value.private_visibility_config_networks :
    network == "CORE_VPC_LINK" ? data.terraform_remote_state.networking_core.outputs.main_vpc_self_link :
    network == "DMZ_VPC_LINK" ? data.terraform_remote_state.networking_dmz.outputs.dmz_vpc_self_link :
    network
  ]
  
  labels = each.value.labels
}

# Create DNS Records
module "dns_records" {
  source = "../../modules/gcp-dns-record"
  
  for_each = var.dns_records
  
  project_id   = each.value.project_id
  zone_id      = module.dns_zones[each.value.zone_key].zone_id
  record_name  = each.value.name
  record_type  = each.value.type
  ttl          = each.value.ttl
  rrdatas      = each.value.rrdatas
}

# Create DNS Forwarding Policies
module "dns_forwarding_policies" {
  source = "../../modules/gcp-dns-forwarding"
  
  for_each = var.dns_forwarding_policies
  
  project_id        = each.value.project_id
  policy_name       = each.value.policy_name
  network_self_link = (
    each.value.network_self_link == "CORE_VPC_LINK" ? data.terraform_remote_state.networking_core.outputs.main_vpc_self_link :
    each.value.network_self_link == "DMZ_VPC_LINK" ? data.terraform_remote_state.networking_dmz.outputs.dmz_vpc_self_link :
    each.value.network_self_link
  )
  
  enable_inbound_forwarding = each.value.enable_inbound_forwarding
  enable_logging           = each.value.enable_logging
  description              = each.value.description
  
  forwarding_zones = each.value.forwarding_zones
}