output "psc_endpoint_ip" {
  description = "The IP address of the PSC endpoint"
  value       = google_compute_forwarding_rule.psc_endpoint.ip_address
}

output "forwarding_rule_id" {
  description = "The ID of the forwarding rule"
  value       = google_compute_forwarding_rule.psc_endpoint.id
}
