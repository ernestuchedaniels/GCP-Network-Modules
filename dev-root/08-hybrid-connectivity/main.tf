terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Visa-replica"
    workspaces {
      name = "dev-08-hybrid-connectivity"
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
    organization = "Visa-replica"
    workspaces = {
      name = "dev-01-project-setup"
    }
  }
}

data "terraform_remote_state" "networking_core" {
  backend = "remote"
  config = {
    organization = "Visa-replica"
    workspaces = {
      name = "dev-02-networking-core"
    }
  }
}

# All resources commented out to destroy everything
# Uncomment to recreate resources

# Create Cloud Routers
module "cloud_routers" {
  source = "../../modules/gcp-cloud-router"
  
  for_each = var.cloud_routers
  
  project_id   = each.value.project_id
  router_name  = each.value.name
  network_link = "projects/${each.value.project_id}/global/networks/${each.value.network}"
  region       = each.value.region
  description  = each.value.description
}

# # Create External VPN Gateway
# resource "google_compute_external_vpn_gateway" "peer_gateway" {
#   count = var.enable_vpn ? 1 : 0
#   
#   project         = data.terraform_remote_state.project_setup.outputs.host_project_id
#   name            = "peer-vpn-gateway"
#   redundancy_type = "TWO_IPS_REDUNDANCY"
#   
#   interface {
#     id         = 0
#     ip_address = var.peer_gateway_ip_0
#   }
#   
#   interface {
#     id         = 1
#     ip_address = var.peer_gateway_ip_1
#   }
# }

# # Create HA VPN Gateway
# module "ha_vpn" {
#   source = "../../modules/gcp-cloud-vpn"
#   
#   count = var.enable_vpn ? 1 : 0
#   
#   project_id           = data.terraform_remote_state.project_setup.outputs.host_project_id
#   region               = var.vpn_region
#   vpn_gateway_name     = "${local.environment}-vpn-gateway"
#   network_self_link    = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
#   tunnel_name_prefix   = "${local.environment}-vpn"
#   router_name          = module.cloud_router.router_name
#   peer_vpn_gateway_id  = google_compute_external_vpn_gateway.peer_gateway[0].id
#   shared_secrets       = var.vpn_shared_secrets
#   interface_ip_ranges  = var.vpn_interface_ip_ranges
#   peer_ip_addresses    = var.vpn_peer_ip_addresses
#   peer_asn             = var.vpn_peer_asn
#   advertised_ip_ranges = var.vpn_advertised_ip_ranges
#   
#   depends_on = [google_compute_external_vpn_gateway.peer_gateway]
# }
