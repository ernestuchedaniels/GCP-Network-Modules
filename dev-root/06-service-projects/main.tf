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

# Create Service Project
module "app_service_project" {
  source = "../../modules/gcp-service-project"
  
  project_id       = var.app_project_id
  project_name     = "${var.app_project_id}-${local.environment}"
  billing_account  = var.billing_account
  host_project_id  = data.terraform_remote_state.project_setup.outputs.host_project_id
  org_id           = var.org_id
  
  labels = {
    environment = local.environment
    purpose     = "service-project"
  }
}

# Attach Service Project to Shared VPC
module "shared_vpc_attachment" {
  source = "../../modules/gcp-shared-vpc-attach"
  
  project_id             = data.terraform_remote_state.project_setup.outputs.host_project_id
  host_project_id        = data.terraform_remote_state.project_setup.outputs.host_project_id
  service_project_number = module.app_service_project.project_number
  
  depends_on = [module.app_service_project]
}