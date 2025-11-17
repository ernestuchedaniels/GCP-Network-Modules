terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Visa-replica"
    workspaces {
      name = "dev-09-service-projects"
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

# Create Service Projects and attach to Shared VPC
module "service_projects" {
  source = "../../modules/gcp-service-project"
  
  for_each = var.service_projects
  
  project_id       = each.value.project_id
  project_name     = each.value.project_name
  billing_account  = each.value.billing_account
  host_project_id  = data.terraform_remote_state.project_setup.outputs.host_project_id
  org_id           = each.value.org_id
  labels           = each.value.labels
}