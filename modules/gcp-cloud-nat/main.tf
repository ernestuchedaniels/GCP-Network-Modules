# Reserve static IPs for Cloud NAT
resource "google_compute_address" "nat_ips" {
  count = var.nat_ip_count
  
  name         = "${var.nat_name}-ip-${count.index + 1}"
  project      = var.project_id
  region       = var.region
  address_type = "EXTERNAL"
}

# Create Cloud NAT
resource "google_compute_router_nat" "nat_gateway" {
  name   = var.nat_name
  router = var.router_name
  region = var.region
  project = var.project_id

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.nat_ips[*].self_link

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  
  dynamic "subnetwork" {
    for_each = var.source_subnet_cidrs
    content {
      name                    = subnetwork.value.subnet_name
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  }

  log_config {
    enable = var.enable_logging
    filter = "ERRORS_ONLY"
  }
}