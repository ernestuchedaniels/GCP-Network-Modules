terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.45"
    }
  }
}

locals {
  environment = "prod"
}

# Read outputs from previous stages
data "terraform_remote_state" "project_setup" {
  backend = "local"
  config = {
    path = "../01-project-setup/terraform.tfstate"
  }
}

data "terraform_remote_state" "networking_core" {
  backend = "local"
  config = {
    path = "../02-networking-core/terraform.tfstate"
  }
}

# Create Private DNS Zone
module "private_dns_zone" {
  source = "../../modules/gcp-dns-zone"
  
  project_id  = data.terraform_remote_state.project_setup.outputs.host_project_id
  zone_name   = "${local.environment}-internal-zone"
  dns_suffix  = "${local.environment}.internal."
  description = "Private DNS zone for ${local.environment} environment"
  visibility  = "private"
  
  private_visibility_config_networks = [data.terraform_remote_state.networking_core.outputs.main_vpc_self_link]
  
  labels = {
    environment = local.environment
  }
}

# Create DNS Records
module "api_dns_record" {
  source = "../../modules/gcp-dns-record"
  
  project_id   = data.terraform_remote_state.project_setup.outputs.host_project_id
  zone_id      = module.private_dns_zone.zone_id
  record_name  = "api.${local.environment}.internal."
  record_type  = "A"
  ttl          = 300
  rrdatas      = ["10.20.1.10"]
}

# Create DNS Forwarding for On-Premises Integration
module "dns_forwarding" {
  source = "../../modules/gcp-dns-forwarding"
  
  project_id        = data.terraform_remote_state.project_setup.outputs.host_project_id
  policy_name       = "${local.environment}-dns-forwarding-policy"
  network_self_link = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  
  enable_inbound_forwarding = true
  enable_logging           = true
  description              = "DNS forwarding policy for ${local.environment} environment"
  
  forwarding_zones = [
    {
      name        = "${local.environment}-onprem-zone"
      dns_name    = "onprem.local."
      description = "Forward queries to on-premises DNS"
      target_name_servers = [
        {
          ipv4_address = var.onprem_dns_server_1
        },
        {
          ipv4_address = var.onprem_dns_server_2
        }
      ]
    }
  ]
}