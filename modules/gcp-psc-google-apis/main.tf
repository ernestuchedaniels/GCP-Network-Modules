resource "google_compute_global_forwarding_rule" "psc_endpoint" {
  project = var.project_id
  name    = var.endpoint_name
  target  = var.target
  network = var.network
}
