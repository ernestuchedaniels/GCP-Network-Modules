resource "google_compute_global_forwarding_rule" "psc_endpoint" {
  project               = var.project_id
  name                  = var.endpoint_name
  load_balancing_scheme = ""
  target                = var.service_bundle
  network               = var.network_link
  labels                = var.labels
}
