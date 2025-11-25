output "main_vpc_self_link" {
  description = "Self-link of the main VPC"
  value       = module.vpcs["main_vpc"].vpc_self_link
}

output "subnets" {
  description = "Map of subnet self-links"
  value       = { for k, v in module.subnets : k => v.subnet_self_link }
}

output "subnets_by_app" {
  description = "Map of subnet self-links by app name"
  value = {
    for k, v in var.subnets :
    v.app_name => module.subnets[k].subnet_self_link
  }
}