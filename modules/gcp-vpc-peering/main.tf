resource "google_compute_network_peering" "peering" {
  name                 = var.peering_name
  network              = var.local_vpc_link
  peer_network         = var.peer_vpc_link
  import_custom_routes = var.import_custom_routes
  export_custom_routes = var.export_custom_routes
}