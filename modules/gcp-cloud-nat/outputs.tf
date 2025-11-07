output "nat_name" {
  description = "Name of the Cloud NAT"
  value       = google_compute_router_nat.nat_gateway.name
}

output "nat_ips" {
  description = "Static IP addresses used by NAT"
  value       = google_compute_address.nat_ips[*].address
}