output "zone_id" {
  description = "The ID of the DNS zone"
  value       = google_dns_managed_zone.zone.id
}

output "zone_name" {
  description = "The name of the DNS zone"
  value       = google_dns_managed_zone.zone.name
}

output "name_servers" {
  description = "The name servers for the DNS zone"
  value       = google_dns_managed_zone.zone.name_servers
}

output "dns_suffix" {
  description = "The DNS suffix/domain name for the zone"
  value       = google_dns_managed_zone.zone.dns_name
}