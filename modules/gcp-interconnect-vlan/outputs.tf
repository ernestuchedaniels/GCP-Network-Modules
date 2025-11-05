output "vlan_self_link" {
  description = "The self-link of the interconnect attachment"
  value       = google_compute_interconnect_attachment.vlan_attachment.self_link
}

output "vlan_name" {
  description = "The name of the interconnect attachment"
  value       = google_compute_interconnect_attachment.vlan_attachment.name
}

output "vlan_id" {
  description = "The ID of the interconnect attachment"
  value       = google_compute_interconnect_attachment.vlan_attachment.id
}