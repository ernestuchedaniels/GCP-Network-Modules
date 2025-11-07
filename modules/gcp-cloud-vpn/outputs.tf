output "vpn_gateway_id" {
  description = "ID of the HA VPN Gateway"
  value       = google_compute_ha_vpn_gateway.vpn_gateway.id
}

output "vpn_gateway_self_link" {
  description = "Self link of the HA VPN Gateway"
  value       = google_compute_ha_vpn_gateway.vpn_gateway.self_link
}

output "tunnel_self_links" {
  description = "Self links of VPN tunnels"
  value       = google_compute_vpn_tunnel.tunnels[*].self_link
}

output "tunnel_names" {
  description = "Names of VPN tunnels"
  value       = google_compute_vpn_tunnel.tunnels[*].name
}