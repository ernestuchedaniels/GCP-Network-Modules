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

  dynamic "secondary_ip_range" {
    for_each = var.secondary_ranges
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }
}