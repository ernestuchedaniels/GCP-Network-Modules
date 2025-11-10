resource "google_compute_forwarding_rule" "psc_endpoint" {
  project               = var.project_id
  name                  = var.endpoint_name
  region                = var.region
  load_balancing_scheme = ""
  target                = var.service_attachment_uri
  subnetwork            = var.subnet_link
  labels                = var.labels
  description           = var.description
}