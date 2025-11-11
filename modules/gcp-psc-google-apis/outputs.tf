output "psc_endpoint_ip" {
  description = "IP address of the PSC endpoint"
  value       = google_compute_global_forwarding_rule.psc_endpoint.ip_address
}

output "psc_endpoint_name" {
  description = "Name of the PSC endpoint"
  value       = google_compute_global_forwarding_rule.psc_endpoint.name
}
