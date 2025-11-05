resource "google_network_connectivity_spoke" "spoke" {
  project     = var.project_id
  name        = var.spoke_name
  location    = var.location
  hub         = var.hub_self_link
  description = var.description
  labels      = var.labels

  linked_vpc_network {
    uri = var.vpc_self_link
  }
}