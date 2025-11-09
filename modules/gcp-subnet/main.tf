locals {
  valid_regions = [
    "us-central1", "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4",
    "europe-west1", "europe-west2", "europe-west3", "europe-west4", "europe-west6",
    "asia-east1", "asia-northeast1", "asia-southeast1", "australia-southeast1"
  ]
}

resource "random_id" "subnet_suffix" {
  byte_length = 2
}

resource "google_compute_subnetwork" "subnet" {
  project                  = var.project_id
  name                     = "${var.app_name}-subnet-${random_id.subnet_suffix.hex}"
  ip_cidr_range            = var.cidr_block
  region                   = var.region
  network                  = var.vpc_link
  description              = var.description
  private_ip_google_access = var.private_ip_google_access

  lifecycle {
    precondition {
      condition = can(cidrhost(var.cidr_block, 0))
      error_message = "Invalid CIDR format: ${var.cidr_block}"
    }
    precondition {
      condition = (
        can(regex("^10\\.", split("/", var.cidr_block)[0])) ||
        (can(regex("^172\\.", split("/", var.cidr_block)[0])) && 
         tonumber(split(".", split("/", var.cidr_block)[0])[1]) >= 16 && 
         tonumber(split(".", split("/", var.cidr_block)[0])[1]) <= 31) ||
        can(regex("^192\\.168\\.", split("/", var.cidr_block)[0]))
      )
      error_message = "CIDR ${var.cidr_block} is not a private IP range (RFC 1918)"
    }
    precondition {
      condition = contains(local.valid_regions, var.region)
      error_message = "Invalid region '${var.region}'. Valid regions: ${join(", ", local.valid_regions)}"
    }
    precondition {
      condition = can(regex("^[a-z]([a-z0-9-]*[a-z0-9])?$", var.app_name)) && length(var.app_name) <= 50
      error_message = "Invalid app name '${var.app_name}'. Must start with lowercase letter, contain only lowercase letters, numbers, and hyphens, end with letter/number, max 50 chars"
    }
  }

  dynamic "secondary_ip_range" {
    for_each = var.secondary_ranges
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}