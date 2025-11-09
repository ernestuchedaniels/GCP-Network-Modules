terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "Visa-replica"
    workspaces {
      name = "dev-06-dns-records"
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

# Read outputs from DNS management stage
data "terraform_remote_state" "dns_management" {
  backend = "remote"
  config = {
    organization = "Visa-replica"
    workspaces = {
      name = "dev-05-dns-management"
    }
  }
}

# Create DNS Records
module "dns_records" {
  source = "../../modules/gcp-dns-record"
  
  for_each = var.dns_records
  
  project_id   = each.value.project_id
  zone_id      = data.terraform_remote_state.dns_management.outputs.dns_zones[each.value.zone_key].zone_id
  record_name  = each.value.name
  record_type  = each.value.type
  ttl          = each.value.ttl
  rrdatas      = each.value.rrdatas
}