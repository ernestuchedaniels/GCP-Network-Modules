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
  
  # Derive region from subnet self-link
  subnet_regions = {
    for k, v in var.psc_endpoints :
    k => split("/", data.terraform_remote_state.networking_core.outputs.subnets_by_app[v.app_name])[8]
  }
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



# Google API PSC Endpoints (global)
module "google_api_endpoints" {
  source = "../../modules/gcp-psc-google-apis"
  
  for_each = var.google_api_endpoints
  
  project_id    = data.terraform_remote_state.project_setup.outputs.host_project_id
  endpoint_name = "${local.environment}${each.key}"
  network_link  = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  service_bundle = each.value.service_bundle
}

# Third-party PSC Endpoints (regional)
module "psc_endpoints" {
  source = "../../modules/gcp-psc-endpoint"
  
  for_each = var.psc_endpoints
  
  project_id             = data.terraform_remote_state.project_setup.outputs.host_project_id
  endpoint_name          = "${local.environment}-${each.key}-psc"
  subnet_link            = data.terraform_remote_state.networking_core.outputs.subnets_by_app[each.value.app_name]
  service_attachment_uri = each.value.service_attachment_uri
  region                 = local.subnet_regions[each.key]
  description            = "PSC endpoint for ${each.key} in ${each.value.app_name} subnet"
  labels = {
    environment = local.environment
    app         = each.value.app_name
    service     = each.key
  }
}