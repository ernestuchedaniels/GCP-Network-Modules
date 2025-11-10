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
  # Deploy Stage 06 DNS Records
  # Scalable zone lookup - finds the first zone that matches each dns_suffix
  # Works with any number of zones and suffixes without hardcoding
  zone_lookup = {
    for suffix in distinct([for record in var.dns_records : record.dns_suffix]) :
    suffix => values(data.terraform_remote_state.dns_management.outputs.dns_zones)[0].zone_id
  }
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
  zone_id      = local.zone_lookup[each.value.dns_suffix]
  record_name  = "${each.value.record_name}.${each.value.dns_suffix}"
  record_type  = each.value.type
  ttl          = each.value.ttl
  rrdatas      = each.value.rrdatas
}