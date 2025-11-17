output "cloud_router_name" {
  description = "Name of the Cloud Router"
  value       = module.cloud_router.router_name
}

output "vpn_gateway_id" {
  description = "ID of the HA VPN Gateway"
  value       = var.enable_vpn ? module.ha_vpn[0].vpn_gateway_id : null
}

output "vpn_gateway_self_link" {
  description = "Self link of the HA VPN Gateway"
  value       = var.enable_vpn ? module.ha_vpn[0].vpn_gateway_self_link : null
}
