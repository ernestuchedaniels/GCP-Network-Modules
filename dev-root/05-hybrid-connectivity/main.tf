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

# Create Cloud Router
module "cloud_router" {
  source = "../../modules/gcp-cloud-router"
  
  project_id   = data.terraform_remote_state.project_setup.outputs.host_project_id
  router_name  = "${local.environment}-hybrid-router"
  network_link = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  region       = var.region
  description  = "Cloud Router for hybrid connectivity in ${local.environment}"
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

# Create Interconnect VLAN Attachments
module "interconnect_vlans" {
  source = "../../modules/gcp-interconnect-vlan"
  
  for_each = var.vlan_attachments
  
  project_id        = data.terraform_remote_state.project_setup.outputs.host_project_id
  router_name       = module.cloud_router.router_name
  region            = each.value.region
  interconnect_name = each.value.name
  type              = each.value.type
  bandwidth         = each.value.bandwidth
  description       = each.value.description
}