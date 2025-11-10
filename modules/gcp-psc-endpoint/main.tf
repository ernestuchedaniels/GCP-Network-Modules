resource "google_compute_address" "psc_address" {
  project      = var.project_id
  name         = "${var.endpoint_name}-ip"
  region       = var.region
  subnetwork   = var.subnet_link
  address_type = "INTERNAL"
}

resource "google_compute_forwarding_rule" "psc_endpoint" {
  project               = var.project_id
  name                  = var.endpoint_name
  region                = var.region
  ip_address            = google_compute_address.psc_address.self_link
  target                = var.service_attachment_uri
  labels                = var.labels
  description           = var.description
  
  depends_on = [google_compute_address.psc_address]
}