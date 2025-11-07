output "dmz_host_project_id" {
  description = "The DMZ host project ID"
  value       = module.dmz_host_project.project_id
}

output "dmz_vpc_self_link" {
  description = "The self link of the DMZ VPC"
  value       = module.dmz_vpc.vpc_self_link
}

output "dmz_vpc_id" {
  description = "The ID of the DMZ VPC"
  value       = module.dmz_vpc.vpc_id
}

output "dmz_subnets" {
  description = "Map of DMZ subnet self links"
  value = {
    for k, v in module.dmz_subnets : k => v.subnet_self_link
  }
}