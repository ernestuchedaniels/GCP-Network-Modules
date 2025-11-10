output "dns_zones" {
  description = "Map of created DNS zones"
  value = {
    for k, v in module.dns_zones : k => {
      zone_id      = v.zone_id
      zone_name    = v.zone_name
      dns_suffix   = v.dns_suffix
      name_servers = v.name_servers
    }
  }
}

output "dns_forwarding_policies" {
  description = "Map of created DNS forwarding policies"
  value = {
    for k, v in module.dns_forwarding_policies : k => {
      policy_id = v.policy_id
      forwarding_zone_ids = v.forwarding_zone_ids
    }
  }
}