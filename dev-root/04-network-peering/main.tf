terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Visa-replica"
    workspaces {
      name = "dev-04-network-peering"
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

# Create VPC Peering Connections
module "vpc_peering" {
  source = "../../modules/gcp-vpc-peering"
  
  for_each = var.vpc_peering_connections
  
  peering_name         = each.value.peering_name
  local_vpc_link       = each.value.local_vpc_link
  peer_vpc_link        = each.value.peer_vpc_link
  import_custom_routes = each.value.import_custom_routes
  export_custom_routes = each.value.export_custom_routes
}