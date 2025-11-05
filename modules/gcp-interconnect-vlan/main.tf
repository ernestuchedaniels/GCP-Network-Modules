resource "google_compute_interconnect_attachment" "vlan_attachment" {
  project                  = var.project_id
  name                     = var.interconnect_name
  region                   = var.region
  router                   = var.router_name
  type                     = var.type
  edge_availability_domain = var.edge_availability_domain
  admin_enabled            = var.admin_enabled
  bandwidth                = var.bandwidth
  description              = var.description
}