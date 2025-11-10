terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Visa-replica"
    workspaces {
      name = "dev-10-private-access"
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
    organization = "Visa-replica"
    workspaces = {
      name = "dev-01-project-setup"
    }
  }
}

data "terraform_remote_state" "networking_core" {
  backend = "remote"
  config = {
    organization = "Visa-replica"
    workspaces = {
      name = "dev-02-networking-core"
    }
  }
}

# Uncomment when using service projects
# data "terraform_remote_state" "service_projects" {
#   backend = "remote"
#   config = {
#     organization = "Visa-replica"
#     workspaces = {
#       name = "dev-09-service-projects"
#     }
#   }
# }



# Create PSC Endpoints
module "psc_endpoints" {
  source = "../../modules/gcp-psc-endpoint"
  
  for_each = var.psc_endpoints
  project_id             = data.terraform_remote_state.project_setup.outputs.project_id
  endpoint_name          = each.value.name
  subnet_link            = data.terraform_remote_state.networking_core.outputs.subnets[each.value.app_name]
  #service_attachment_uri = each.value.service_attachment_uri
  region                 = each.value.region
  description            = each.value.description
  labels = each.value.labels
}