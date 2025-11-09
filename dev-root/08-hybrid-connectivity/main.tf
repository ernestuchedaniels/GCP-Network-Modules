terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "your-tfe-organization"
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
    workspace = "dev-01-project-setup"
  }
}

data "terraform_remote_state" "networking_core" {
  backend = "remote"
  config = {
    workspace = "dev-02-networking-core"
  }
}

data "terraform_remote_state" "networking_dmz" {
  backend = "remote"
  config = {
    workspace = "dev-03-networking-dmz"
  }
}

# Create Cloud Router for Core VPC
module "cloud_router_core" {
  source = "../../modules/gcp-cloud-router"
  
  project_id   = data.terraform_remote_state.project_setup.outputs.host_project_id
  router_name  = "${local.environment}-core-hybrid-router"
  network_link = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  region       = var.region
  description  = "Cloud Router for core VPC hybrid connectivity"
}

# Create Cloud Router for DMZ VPC
module "cloud_router_dmz" {
  source = "../../modules/gcp-cloud-router"
  
  project_id   = data.terraform_remote_state.networking_dmz.outputs.dmz_host_project_id
  router_name  = "${local.environment}-dmz-hybrid-router"
  network_link = data.terraform_remote_state.networking_dmz.outputs.dmz_vpc_self_link
  region       = var.region
  description  = "Cloud Router for DMZ VPC hybrid connectivity"
}

# Create NCC Hub
module "ncc_hub" {
  source = "../../modules/gcp-ncc-hub"
  
  project_id  = data.terraform_remote_state.project_setup.outputs.host_project_id
  hub_name    = "${local.environment}-ncc-hub"
  description = "NCC Hub for ${local.environment} environment"
  
  labels = {
    environment = local.environment
  }
}

# Create Interconnect VLAN Attachments for Core VPC
module "interconnect_vlans_core" {
  source = "../../modules/gcp-interconnect-vlan"
  
  for_each = var.vlan_attachments
  
  project_id        = data.terraform_remote_state.project_setup.outputs.host_project_id
  router_name       = module.cloud_router_core.router_name
  region            = each.value.region
  interconnect_name = each.value.name
  type              = each.value.type
  bandwidth         = each.value.bandwidth
  description       = each.value.description
}