terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Visa-replica"
    workspaces {
      name = "prod-03-networking-dmz"
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

# Create DMZ Host Project
module "dmz_host_project" {
  source = "../../modules/gcp-host-project"
  
  project_id      = var.dmz_project_id
  project_name    = "${var.dmz_project_id}-${local.environment}"
  billing_account = var.billing_account
  org_id          = var.org_id
  
  labels = {
    environment = local.environment
    purpose     = "dmz-host"
  }
}

# Create DMZ VPC Network
module "dmz_vpc" {
  source = "../../modules/gcp-vpc"
  
  project_id              = module.dmz_host_project.project_id
  network_name            = "${local.environment}-dmz-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  description             = "DMZ VPC for ${local.environment} environment"
}

# Create DMZ Subnets
module "dmz_subnets" {
  source = "../../modules/gcp-subnet"
  
  for_each = var.dmz_subnets
  
  project_id               = module.dmz_host_project.project_id
  app_name                 = each.value.app_name
  cidr_block              = each.value.cidr_block
  region                  = each.value.region
  vpc_link                = module.dmz_vpc.vpc_self_link
  private_ip_google_access = each.value.private_ip_google_access
  description             = each.value.description
  
  secondary_ranges = each.value.secondary_ranges
}