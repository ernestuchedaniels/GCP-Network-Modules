terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Visa-replica"
    workspaces {
      name = "dev-03-networking-dmz"
    }
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.45"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

locals {
  environment = "dev"
}

# Read outputs from 01-project-setup
data "terraform_remote_state" "project_setup" {
  backend = "remote"
  config = {
    organization = "Visa-replica"
    workspaces = {
      name = "dev-01-project-setup"
    }
  }
}

# Create DMZ VPC Network
module "dmz_vpc" {
  source = "../../modules/gcp-vpc"
  
  project_id              = data.terraform_remote_state.project_setup.outputs.host_project_id
  network_name            = "${local.environment}-dmz-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  description             = "DMZ VPC for ${local.environment} environment"
}

# Create DMZ Subnets
module "dmz_subnets" {
  source = "../../modules/gcp-subnet"
  
  for_each = var.dmz_subnets
  
  project_id               = data.terraform_remote_state.project_setup.outputs.host_project_id
  app_name                 = each.value.app_name
  cidr_block              = each.value.cidr_block
  region                  = each.value.region
  vpc_link                = module.dmz_vpc.vpc_self_link
  private_ip_google_access = each.value.private_ip_google_access
  description             = each.value.description
  
  secondary_ranges = each.value.secondary_ranges
}