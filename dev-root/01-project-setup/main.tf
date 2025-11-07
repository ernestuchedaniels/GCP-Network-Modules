terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Visa-replica"
    workspaces {
      name = "dev-01-project-setup"
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

# Use existing project and enable services
resource "google_project_service" "apis" {
  for_each = toset([
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "servicenetworking.googleapis.com",
  ])
  project            = var.host_project_id
  service            = each.value
  disable_on_destroy = false
}

resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
  project    = var.host_project_id
  depends_on = [google_project_service.apis]
}

