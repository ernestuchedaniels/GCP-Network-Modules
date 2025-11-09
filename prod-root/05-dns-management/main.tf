terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Visa-replica"
    workspaces {
      name = "prod-05-dns-management"
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
  environment = "prod"
  # Automatically include all available VPCs for DNS visibility
  all_vpc_links = [
    data.terraform_remote_state.networking_core.outputs.main_vpc_self_link,
    data.terraform_remote_state.networking_dmz.outputs.dmz_vpc_self_link
  ]
  
  # VPC lookup map for flexible network selection
  vpc_lookup = {
    "CORE_VPC" = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
    "DMZ_VPC"  = data.terraform_remote_state.networking_dmz.outputs.dmz_vpc_self_link
  }
}

# Read outputs from previous stages
data "terraform_remote_state" "project_setup" {
  backend = "remote"
  config = {
    organization = "Visa-replica"
    workspaces = {
      name = "prod-01-project-setup"
    }
  }
}

data "terraform_remote_state" "networking_core" {
  backend = "remote"
  config = {
    organization = "Visa-replica"
    workspaces = {
      name = "prod-02-networking-core"
    }
  }
}

data "terraform_remote_state" "networking_dmz" {
  backend = "remote"
  config = {
    organization = "Visa-replica"
    workspaces = {
      name = "prod-03-networking-dmz"
    }
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
    for vpc in each.value.vpc_networks : local.vpc_lookup[vpc]
  ]
  
  labels = each.value.labels
}

# Create DNS Forwarding Policies
module "dns_forwarding_policies" {
  source = "../../modules/gcp-dns-forwarding"
  
  for_each = var.dns_forwarding_policies
  
  project_id        = each.value.project_id
  policy_name       = each.value.policy_name
  network_self_link = local.vpc_lookup[each.value.network_self_link]
  
  enable_inbound_forwarding = each.value.enable_inbound_forwarding
  enable_logging           = each.value.enable_logging
  description              = each.value.description
  
  forwarding_zones = each.value.forwarding_zones
}