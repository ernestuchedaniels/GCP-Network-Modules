terraform {
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

# Read outputs from 01-project-setup
data "terraform_remote_state" "project_setup" {
  backend = "local"
  config = {
    path = "../01-project-setup/terraform.tfstate"
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

# Create Primary Subnet
module "primary_subnet" {
  source = "../../modules/gcp-subnet"
  
  project_id                = data.terraform_remote_state.project_setup.outputs.host_project_id
  subnet_name               = "${local.environment}-primary-subnet"
  cidr_block                = var.primary_dev_cidr
  region                    = var.region
  vpc_link                  = module.main_vpc.vpc_self_link
  private_ip_google_access  = true
  description               = "Primary subnet for ${local.environment} environment"
  
  secondary_ranges = [
    {
      range_name    = "pods"
      ip_cidr_range = var.pods_cidr
    },
    {
      range_name    = "services"
      ip_cidr_range = var.services_cidr
    }
  ]
}