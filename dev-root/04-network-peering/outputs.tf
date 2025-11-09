output "core_to_dmz_peering_name" {
  description = "Name of the Core to DMZ peering connection"
  value       = module.core_to_dmz_peering.peering_name
}

output "dmz_to_core_peering_name" {
  description = "Name of the DMZ to Core peering connection"
  value       = module.dmz_to_core_peering.peering_name
}

output "peering_status" {
  description = "Status of VPC peering connections"
  value = {
    core_to_dmz = "established"
    dmz_to_core = "established"
  }
}