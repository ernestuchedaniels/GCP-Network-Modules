resource "google_compute_global_address" "psc_address" {
  project      = var.project_id
  name         = "${var.endpoint_name}-address"
  address_type = "INTERNAL"
  purpose      = "PRIVATE_SERVICE_CONNECT"
  network      = var.network
}

resource "google_compute_global_forwarding_rule" "psc_endpoint" {
  project    = var.project_id
  name       = var.endpoint_name
  target     = var.target
  network    = var.network
  ip_address = google_compute_global_address.psc_address.id
}
