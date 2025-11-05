resource "google_compute_router" "router" {
  project     = var.project_id
  name        = var.router_name
  region      = var.region
  network     = var.network_link
  description = var.description

  bgp {
    asn = var.bgp_asn
  }
}