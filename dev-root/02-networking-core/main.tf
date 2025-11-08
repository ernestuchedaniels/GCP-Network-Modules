terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Visa-replica"
    workspaces {
      name = "dev-02-networking-core"
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

# Core networking infrastructure for dev environment
# Testing GitOps workflow with feature branch speculative plans

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

# Create VPC Network
module "main_vpc" {
  source = "../../modules/gcp-vpc"
  
  project_id              = data.terraform_remote_state.project_setup.outputs.host_project_id
  network_name            = "${local.environment}-shared-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  description             = "Shared VPC for ${local.environment} environment"
}

# Create Subnets
module "subnets" {
  source = "../../modules/gcp-subnet"
  
  for_each = var.subnets
  
  project_id                = data.terraform_remote_state.project_setup.outputs.host_project_id
  app_name                  = each.value.app_name
  cidr_block                = each.value.cidr_block
  region                    = each.value.region
  vpc_link                  = module.main_vpc.vpc_self_link
  private_ip_google_access  = each.value.private_ip_google_access
  description               = each.value.description
  
  secondary_ranges = each.value.secondary_ranges
}