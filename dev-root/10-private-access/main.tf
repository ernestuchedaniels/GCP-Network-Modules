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
  
  # Derive region from subnet self-link for service attachments
  # service_attachment_regions = {
  #   for k, v in var.psc_service_attachments :
  #   k => split("/", data.terraform_remote_state.networking_core.outputs.subnets_by_app[v.app_name])[8]
  # }
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

# Google API PSC Endpoints (global)
module "google_api_psc" {
  source = "../../modules/gcp-psc-google-apis"
  
  for_each = var.psc_google_apis
  
  project_id    = data.terraform_remote_state.project_setup.outputs.host_project_id
  endpoint_name = replace("${local.environment}${each.key}", "-", "")
  network       = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  target        = each.value.target
  ip_address    = each.value.ip_address
}

# Third-party PSC Endpoints (regional) - Commented out to focus on Google API PSC first
# module "service_attachment_psc" {
#   source = "../../modules/gcp-psc-service-attachment"
#   
#   for_each = var.psc_service_attachments
#   
#   project_id    = data.terraform_remote_state.project_setup.outputs.host_project_id
#   endpoint_name = "${local.environment}-${each.key}-psc"
#   region        = local.service_attachment_regions[each.key]
#   subnetwork    = data.terraform_remote_state.networking_core.outputs.subnets_by_app[each.value.app_name]
#   network       = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
#   target        = each.value.target
# }
