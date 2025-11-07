# Create HA VPN Gateway
resource "google_compute_ha_vpn_gateway" "vpn_gateway" {
  name    = var.vpn_gateway_name
  region  = var.region
  network = var.network_self_link
  project = var.project_id
}

# Create VPN Tunnels
resource "google_compute_vpn_tunnel" "tunnels" {
  count = 2
  
  name                  = "${var.tunnel_name_prefix}-tunnel-${count.index + 1}"
  region                = var.region
  project               = var.project_id
  vpn_gateway           = google_compute_ha_vpn_gateway.vpn_gateway.id
  peer_gcp_gateway      = var.peer_vpn_gateway_id
  shared_secret         = var.shared_secrets[count.index]
  router                = var.router_name
  vpn_gateway_interface = count.index
  peer_gateway_interface = count.index
}

# Create Router Interface
resource "google_compute_router_interface" "router_interface" {
  count = 2
  
  name       = "${var.tunnel_name_prefix}-interface-${count.index + 1}"
  router     = var.router_name
  region     = var.region
  project    = var.project_id
  ip_range   = var.interface_ip_ranges[count.index]
  vpn_tunnel = google_compute_vpn_tunnel.tunnels[count.index].name
}

# Create BGP Peer
resource "google_compute_router_peer" "bgp_peer" {
  count = 2
  
  name                      = "${var.tunnel_name_prefix}-peer-${count.index + 1}"
  router                    = var.router_name
  region                    = var.region
  project                   = var.project_id
  peer_ip_address          = var.peer_ip_addresses[count.index]
  peer_asn                 = var.peer_asn
  advertised_route_priority = var.advertised_route_priority
  interface                = google_compute_router_interface.router_interface[count.index].name
  
  dynamic "advertised_ip_ranges" {
    for_each = var.advertised_ip_ranges
    content {
      range       = advertised_ip_ranges.value.range
      description = advertised_ip_ranges.value.description
    }
  }
}