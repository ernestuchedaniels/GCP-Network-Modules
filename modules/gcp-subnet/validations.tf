locals {
  # Valid GCP regions
  valid_regions = [
    "us-central1", "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4",
    "europe-west1", "europe-west2", "europe-west3", "europe-west4", "europe-west6",
    "asia-east1", "asia-northeast1", "asia-southeast1", "australia-southeast1"
  ]
}

# CIDR Format Validation
resource "terraform_data" "cidr_format_validation" {
  lifecycle {
    precondition {
      condition = can(cidrhost(var.cidr_block, 0))
      error_message = "Invalid CIDR format: ${var.cidr_block}"
    }
  }
}

# Private IP Range Validation (RFC 1918)
resource "terraform_data" "private_ip_validation" {
  lifecycle {
    precondition {
      condition = (
        # 10.0.0.0/8
        can(regex("^10\\.", split("/", var.cidr_block)[0])) ||
        # 172.16.0.0/12
        (can(regex("^172\\.", split("/", var.cidr_block)[0])) && 
         tonumber(split(".", split("/", var.cidr_block)[0])[1]) >= 16 && 
         tonumber(split(".", split("/", var.cidr_block)[0])[1]) <= 31) ||
        # 192.168.0.0/16
        can(regex("^192\\.168\\.", split("/", var.cidr_block)[0]))
      )
      error_message = "CIDR ${var.cidr_block} is not a private IP range (RFC 1918)"
    }
  }
}

# Regional Validation
resource "terraform_data" "region_validation" {
  lifecycle {
    precondition {
      condition = contains(local.valid_regions, var.region)
      error_message = "Invalid region '${var.region}'. Valid regions: ${join(", ", local.valid_regions)}"
    }
  }
}

# App Name Validation (GCP naming conventions)
resource "terraform_data" "app_name_validation" {
  lifecycle {
    precondition {
      condition = can(regex("^[a-z]([a-z0-9-]*[a-z0-9])?$", var.app_name)) && length(var.app_name) <= 50
      error_message = "Invalid app name '${var.app_name}'. Must start with lowercase letter, contain only lowercase letters, numbers, and hyphens, end with letter/number, max 50 chars"
    }
  }
}

# Naming Convention Validation (appname-subnet)
resource "terraform_data" "naming_convention_validation" {
  lifecycle {
    precondition {
      condition = can(regex("^[a-z0-9]+(-[a-z0-9]+)*-subnet$", var.subnet_name))
      error_message = "Subnet name '${var.subnet_name}' does not follow naming convention. Expected format: appname-subnet (e.g., web-subnet, api-subnet, db-subnet)"
    }
  }
}

# Secondary Range CIDR Format Validation
resource "terraform_data" "secondary_cidr_format_validation" {
  count = length(var.secondary_ranges) > 0 ? 1 : 0
  
  lifecycle {
    precondition {
      condition = alltrue([
        for range in var.secondary_ranges : can(cidrhost(range.ip_cidr_range, 0))
      ])
      error_message = "Invalid secondary CIDR format: ${join(", ", [for r in var.secondary_ranges : r.ip_cidr_range])}"
    }
  }
}

# Secondary Range Private IP Validation
resource "terraform_data" "secondary_private_ip_validation" {
  count = length(var.secondary_ranges) > 0 ? 1 : 0
  
  lifecycle {
    precondition {
      condition = alltrue([
        for range in var.secondary_ranges : (
          # 10.0.0.0/8
          can(regex("^10\\.", split("/", range.ip_cidr_range)[0])) ||
          # 172.16.0.0/12
          (can(regex("^172\\.", split("/", range.ip_cidr_range)[0])) && 
           tonumber(split(".", split("/", range.ip_cidr_range)[0])[1]) >= 16 && 
           tonumber(split(".", split("/", range.ip_cidr_range)[0])[1]) <= 31) ||
          # 192.168.0.0/16
          can(regex("^192\\.168\\.", split("/", range.ip_cidr_range)[0]))
        )
      ])
      error_message = "Non-private IP ranges found in secondary ranges"
    }
  }
}

# Naming Convention Validation (appname-subnet)
resource "terraform_data" "naming_convention_validation" {
  lifecycle {
    precondition {
      condition = can(regex("^[a-z0-9]+(-[a-z0-9]+)*-subnet$", var.subnet_name))
      error_message = "Subnet name '${var.subnet_name}' does not follow naming convention. Expected format: appname-subnet (e.g., web-subnet, api-subnet, db-subnet)"
    }
  }
}