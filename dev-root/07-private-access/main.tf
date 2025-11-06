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

# Create PSC Endpoints
module "psc_endpoints" {
  source = "../../modules/gcp-psc-endpoint"
  
  for_each = var.psc_endpoints
  
  project_id             = data.terraform_remote_state.service_projects.outputs.app_service_project_id
  endpoint_name          = each.value.name
  subnet_link            = each.value.subnet_link
  service_attachment_uri = each.value.service_attachment_uri
  region                 = each.value.region
  description            = each.value.description
  
  labels = each.value.labels
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