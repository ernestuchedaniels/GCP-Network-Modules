terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "your-tfe-organization"
    workspaces {
      name = "prod-04-network-peering"
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
}

# Read outputs from previous stages
data "terraform_remote_state" "project_setup" {
  backend = "remote"
  config = {
    workspace = "prod-01-project-setup"
  }
}

data "terraform_remote_state" "networking_core" {
  backend = "remote"
  config = {
    workspace = "prod-02-networking-core"
  }
}

data "terraform_remote_state" "networking_dmz" {
  backend = "remote"
  config = {
    workspace = "prod-03-networking-dmz"
  }
}

# Create Core Cloud Router
module "core_cloud_router" {
  source = "../../modules/gcp-cloud-router"
  
  project_id   = data.terraform_remote_state.project_setup.outputs.host_project_id
  router_name  = "${local.environment}-core-vpn-router"
  network_link = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  region       = var.region
  description  = "Cloud Router for Core VPC VPN connectivity"
}

# Create DMZ Cloud Router
module "dmz_cloud_router" {
  source = "../../modules/gcp-cloud-router"
  
  project_id   = data.terraform_remote_state.networking_dmz.outputs.dmz_host_project_id
  router_name  = "${local.environment}-dmz-vpn-router"
  network_link = data.terraform_remote_state.networking_dmz.outputs.dmz_vpc_self_link
  region       = var.region
  description  = "Cloud Router for DMZ VPC VPN connectivity"
}

# Create Core VPN Gateway and Tunnels
module "core_vpn" {
  source = "../../modules/gcp-cloud-vpn"
  
  project_id            = data.terraform_remote_state.project_setup.outputs.host_project_id
  region               = var.region
  vpn_gateway_name     = "${local.environment}-core-vpn-gateway"
  network_self_link    = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  tunnel_name_prefix   = "${local.environment}-core-to-dmz"
  router_name          = module.core_cloud_router.router_name
  peer_vpn_gateway_id  = module.dmz_vpn.vpn_gateway_id
  shared_secrets       = var.vpn_shared_secrets
  interface_ip_ranges  = var.core_interface_ip_ranges
  peer_ip_addresses    = var.core_peer_ip_addresses
  peer_asn            = var.dmz_asn
  
  depends_on = [module.dmz_vpn]
}

# Create DMZ VPN Gateway and Tunnels
module "dmz_vpn" {
  source = "../../modules/gcp-cloud-vpn"
  
  project_id            = data.terraform_remote_state.networking_dmz.outputs.dmz_host_project_id
  region               = var.region
  vpn_gateway_name     = "${local.environment}-dmz-vpn-gateway"
  network_self_link    = data.terraform_remote_state.networking_dmz.outputs.dmz_vpc_self_link
  tunnel_name_prefix   = "${local.environment}-dmz-to-core"
  router_name          = module.dmz_cloud_router.router_name
  peer_vpn_gateway_id  = module.core_vpn.vpn_gateway_id
  shared_secrets       = var.vpn_shared_secrets
  interface_ip_ranges  = var.dmz_interface_ip_ranges
  peer_ip_addresses    = var.dmz_peer_ip_addresses
  peer_asn            = var.core_asn
  advertised_ip_ranges = [
    {
      range       = "0.0.0.0/0"
      description = "Default route for egress"
    }
  ]
}

# Create Cloud NAT in DMZ
module "dmz_nat" {
  source = "../../modules/gcp-cloud-nat"
  
  project_id         = data.terraform_remote_state.networking_dmz.outputs.dmz_host_project_id
  region            = var.region
  nat_name          = "${local.environment}-dmz-nat"
  router_name       = module.dmz_cloud_router.router_name
  nat_ip_count      = var.nat_ip_count
  source_subnet_cidrs = var.core_subnet_cidrs
  enable_logging    = true
}

# Create static route in Core VPC to force egress through VPN
resource "google_compute_route" "core_default_route" {
  name             = "${local.environment}-core-default-via-vpn"
  dest_range       = "0.0.0.0/0"
  network          = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  next_hop_vpn_tunnel = module.core_vpn.tunnel_self_links[0]
  priority         = 900
  project          = data.terraform_remote_state.project_setup.outputs.host_project_id
  description      = "Force all egress traffic through VPN to DMZ"
}