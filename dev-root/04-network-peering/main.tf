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

data "terraform_remote_state" "networking_dmz" {
  backend = "remote"
  config = {
    organization = "Visa-replica"
    workspaces = {
      name = "dev-03-networking-dmz"
    }
  }
}

# Create VPC Peering: Core to DMZ
module "core_to_dmz_peering" {
  source = "../../modules/gcp-vpc-peering"
  
  peering_name         = "${local.environment}-core-to-dmz"
  local_vpc_link       = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  peer_vpc_link        = data.terraform_remote_state.networking_dmz.outputs.dmz_vpc_self_link
  import_custom_routes = var.import_custom_routes
  export_custom_routes = var.export_custom_routes
}

# Create VPC Peering: DMZ to Core
module "dmz_to_core_peering" {
  source = "../../modules/gcp-vpc-peering"
  
  peering_name         = "${local.environment}-dmz-to-core"
  local_vpc_link       = data.terraform_remote_state.networking_dmz.outputs.dmz_vpc_self_link
  peer_vpc_link        = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  import_custom_routes = var.import_custom_routes
  export_custom_routes = var.export_custom_routes
}