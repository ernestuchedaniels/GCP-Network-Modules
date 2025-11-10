resource "google_compute_forwarding_rule" "psc_endpoint" {
  project               = var.project_id
  name                  = var.endpoint_name
  region                = var.region
  load_balancing_scheme = ""
  # target                = var.service_attachment_uri
  network               = null
  subnetwork            = var.subnet_link
  ip_address            = var.ip_address
  labels                = var.labels
  description           = var.description
}