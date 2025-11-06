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

data "terraform_remote_state" "hybrid_connectivity" {
  backend = "local"
  config = {
    path = "../03-hybrid-connectivity/terraform.tfstate"
  }
}

# Create monitoring dashboard
module "network_dashboard" {
  source = "../../modules/gcp-monitoring-dashboard"
  
  project_id  = data.terraform_remote_state.project_setup.outputs.host_project_id
  environment = local.environment
}

# Create BGP monitoring alert
module "bgp_alert" {
  source = "../../modules/gcp-monitoring-alert"
  
  project_id           = data.terraform_remote_state.project_setup.outputs.host_project_id
  router_name          = "${local.environment}-hybrid-router"
  region               = var.region
  notification_channel = var.notification_channel_id
}