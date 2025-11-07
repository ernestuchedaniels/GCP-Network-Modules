output "core_vpn_gateway_id" {
  description = "ID of the Core VPN Gateway"
  value       = module.core_vpn.vpn_gateway_id
}

output "dmz_vpn_gateway_id" {
  description = "ID of the DMZ VPN Gateway"
  value       = module.dmz_vpn.vpn_gateway_id
}

output "nat_ips" {
  description = "Static IP addresses used by NAT"
  value       = module.dmz_nat.nat_ips
}