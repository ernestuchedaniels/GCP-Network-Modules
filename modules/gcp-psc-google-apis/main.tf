resource "google_compute_global_address" "psc_address" {
  project      = var.project_id
  name         = "${var.endpoint_name}-ip"
  address_type = "INTERNAL"
  purpose      = "PRIVATE_SERVICE_CONNECT"
  network      = var.network_link
}

resource "google_compute_global_forwarding_rule" "psc_endpoint" {
  project               = var.project_id
  name                  = var.endpoint_name
  load_balancing_scheme = ""
  target                = var.service_bundle
  ip_address            = google_compute_global_address.psc_address.id
  network               = var.network_link
  labels                = var.labels
  
  depends_on = [google_compute_global_address.psc_address]
}
