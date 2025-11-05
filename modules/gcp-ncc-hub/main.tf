resource "google_network_connectivity_hub" "hub" {
  project     = var.project_id
  name        = var.hub_name
  description = var.description
  labels      = var.labels
}