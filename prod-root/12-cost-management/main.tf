terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "your-tfe-organization"
    workspaces {
      name = "prod-12-cost-management"
    }
  }
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.45"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.45"
    }
  }
}

locals {
  environment = "prod"
}

# Read outputs from project setup
data "terraform_remote_state" "project_setup" {
  backend = "remote"
  config = {
    workspace = "prod-08-cost"
  }
}

# Create billing export and cost monitoring
module "billing_export" {
  source = "../../modules/gcp-billing-export"
  
  billing_account_id     = var.billing_account_id
  host_project_id        = data.terraform_remote_state.project_setup.outputs.host_project_id
  dataset_name           = "${local.environment}_network_billing"
  network_team_label_key = "team"
}