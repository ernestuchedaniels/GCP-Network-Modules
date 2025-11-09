output "router_self_link" {
  description = "Self-link of the cloud router"
  value       = module.cloud_router.router_self_link
}

output "vlan_attachment_link" {
  description = "Self-link of the VLAN attachment"
  value       = module.interconnect_vlan.vlan_self_link
}

output "ncc_hub_id" {
  description = "ID of the NCC hub"
  value       = module.ncc_hub.hub_id
}