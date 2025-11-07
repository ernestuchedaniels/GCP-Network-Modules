output "private_dns_zone_id" {
  description = "ID of the private DNS zone"
  value       = module.private_dns_zone.zone_id
}

output "dns_policy_id" {
  description = "ID of the DNS forwarding policy"
  value       = module.dns_forwarding.policy_id
}