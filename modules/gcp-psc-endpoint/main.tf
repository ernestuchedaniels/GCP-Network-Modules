resource "google_compute_address" "psc_address" {
  project      = var.project_id
  name         = "${var.endpoint_name}-ip"
  region       = var.region
  subnetwork   = var.subnet_link
  address_type = "INTERNAL"
  purpose      = "PRIVATE_SERVICE_CONNECT"
}

resource "google_compute_forwarding_rule" "psc_endpoint" {
  depends_on            = [google_compute_address.psc_address]
  project               = var.project_id
  name                  = var.endpoint_name
  region                = var.region
  load_balancing_scheme = ""
  target                = var.service_attachment_uri
  subnetwork            = var.subnet_link
  ip_address            = google_compute_address.psc_address.self_link
  labels                = var.labels
  description           = var.description
}