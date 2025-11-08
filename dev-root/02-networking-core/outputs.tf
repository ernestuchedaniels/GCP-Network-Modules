output "main_vpc_self_link" {
  description = "Self-link of the main VPC"
  value       = module.main_vpc.vpc_self_link
}

output "subnets" {
  description = "Map of subnet self-links"
  value       = { for k, v in module.subnets : k => v.subnet_self_link }
}