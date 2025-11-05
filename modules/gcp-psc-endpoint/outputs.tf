output "psc_internal_ip" {
  description = "The internal IP address of the PSC endpoint"
  value       = google_compute_forwarding_rule.psc_endpoint.ip_address
}