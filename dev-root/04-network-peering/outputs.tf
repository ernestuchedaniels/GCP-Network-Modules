output "vpc_peering_connections" {
  description = "Map of created VPC peering connections"
  value = {
    for k, v in module.vpc_peering : k => {
      peering_name = v.peering_name
      state        = "ACTIVE"
    }
  }
}

output "peering_names" {
  description = "List of all peering connection names"
  value       = [for v in module.vpc_peering : v.peering_name]
}