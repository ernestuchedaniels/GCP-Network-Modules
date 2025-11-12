resource "google_compute_address" "psc_address" {
  project      = var.project_id
  name         = var.endpoint_name
  region       = var.region
  subnetwork   = var.subnetwork
  address_type = "INTERNAL"
  purpose      = "GCE_ENDPOINT"
}

resource "google_compute_forwarding_rule" "psc_endpoint" {
  project               = var.project_id
  name                  = var.endpoint_name
  region                = var.region
  network               = var.network
  ip_address            = google_compute_address.psc_address.id
  target                = "projects/servicenetworking-googleapis-com/regions/${var.region}/serviceAttachments/${var.target}"
  load_balancing_scheme = ""
  allow_global_access   = var.global_access
}
