output "spoke_self_link" {
  description = "The self-link of the NCC spoke"
  value       = google_network_connectivity_spoke.spoke.id
}

output "spoke_name" {
  description = "The name of the NCC spoke"
  value       = google_network_connectivity_spoke.spoke.name
}

output "spoke_id" {
  description = "The ID of the NCC spoke"
  value       = google_network_connectivity_spoke.spoke.id
}