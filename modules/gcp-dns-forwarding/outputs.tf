output "policy_id" {
  description = "The ID of the DNS policy"
  value       = google_dns_policy.forwarding_policy.id
}

output "forwarding_zone_ids" {
  description = "The IDs of the forwarding zones"
  value       = { for k, v in google_dns_managed_zone.forwarding_zone : k => v.id }
}