output "peering_name" {
  description = "The name of the VPC peering connection"
  value       = google_compute_network_peering.peering.name
}

output "peering_id" {
  description = "The ID of the VPC peering connection"
  value       = google_compute_network_peering.peering.id
}

output "peering_state" {
  description = "The state of the VPC peering connection"
  value       = google_compute_network_peering.peering.state
}