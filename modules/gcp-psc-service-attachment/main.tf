resource "google_compute_address" "psc_address" {
  project      = var.project_id
  name         = "${var.endpoint_name}-address"
  region       = var.region
  subnetwork   = var.subnetwork
  address_type = "INTERNAL"
}

resource "google_compute_forwarding_rule" "psc_endpoint" {
  project    = var.project_id
  name       = var.endpoint_name
  region     = var.region
  target     = var.target
  network    = var.network
  ip_address = google_compute_address.psc_address.id
}
