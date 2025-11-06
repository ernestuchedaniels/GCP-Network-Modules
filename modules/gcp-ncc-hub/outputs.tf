output "hub_self_link" {
  description = "The self-link of the NCC hub"
  value       = google_network_connectivity_hub.hub.id
}

output "hub_name" {
  description = "The name of the NCC hub"
  value       = google_network_connectivity_hub.hub.name
}

output "hub_id" {
  description = "The ID of the NCC hub"
  value       = google_network_connectivity_hub.hub.id
}