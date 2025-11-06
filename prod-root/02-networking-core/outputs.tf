output "main_vpc_self_link" {
  description = "Self-link of the main VPC"
  value       = module.main_vpc.vpc_self_link
}

output "primary_subnet_link" {
  description = "Self-link of the primary subnet"
  value       = module.primary_subnet.subnet_self_link
}

output "private_dns_zone_id" {
  description = "ID of the private DNS zone"
  value       = module.private_dns_zone.zone_id
}