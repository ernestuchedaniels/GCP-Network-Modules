output "psc_endpoint_ip" {
  description = "IP address of the PSC endpoint"
  value       = google_compute_address.psc_address.address
}

output "forwarding_rule_id" {
  description = "ID of the forwarding rule"
  value       = google_compute_forwarding_rule.psc_endpoint.id
}
