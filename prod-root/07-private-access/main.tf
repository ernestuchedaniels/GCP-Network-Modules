terraform {
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
data "terraform_remote_state" "networking_core" {
  backend = "local"
  config = {
    path = "../02-networking-core/terraform.tfstate"
  }
}

data "terraform_remote_state" "service_projects" {
  backend = "local"
  config = {
    path = "../04-service-projects/terraform.tfstate"
  }
}

# Create PSC Endpoint
module "psc_endpoint" {
  source = "../../modules/gcp-psc-endpoint"
  
  project_id             = data.terraform_remote_state.service_projects.outputs.app_service_project_id
  endpoint_name          = "${local.environment}-psc-endpoint"
  subnet_link            = data.terraform_remote_state.networking_core.outputs.primary_subnet_link
  service_attachment_uri = var.service_attachment_uri
  region                 = var.region
  description            = "PSC endpoint for ${local.environment} environment"
  
  labels = {
    environment = local.environment
  }
}

# Create VPC Peering (if needed)
module "vpc_peering" {
  source = "../../modules/gcp-vpc-peering"
  
  project_id           = data.terraform_remote_state.service_projects.outputs.app_service_project_id
  peering_name         = "${local.environment}-vpc-peering"
  local_vpc_link       = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  peer_vpc_link        = var.peering_network_url
  import_custom_routes = true
  export_custom_routes = true
}