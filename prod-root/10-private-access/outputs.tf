output "psc_endpoint_ip" {
  description = "IP address of the PSC endpoint"
  value       = module.psc_endpoint.psc_internal_ip
}

output "peering_state" {
  description = "State of the VPC peering connection"
  value       = module.vpc_peering.peering_state
}