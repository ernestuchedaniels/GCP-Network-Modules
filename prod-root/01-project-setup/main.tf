terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "your-tfe-organization"
    workspaces {
      name = "prod-01-project-setup"
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

# Create Host Project
module "host_project" {
  source = "../../modules/gcp-host-project"
  
  project_id      = var.host_project_id
  project_name    = "${var.host_project_id}-${local.environment}"
  billing_account = var.billing_account_id
  org_id          = var.org_id
  
  labels = {
    environment = local.environment
    purpose     = "shared-vpc-host"
  }
}

