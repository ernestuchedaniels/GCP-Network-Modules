variable "dns_zones" {
  description = "Map of DNS zones to create"
  type = map(object({
    project_id                         = string
    zone_name                         = string
    dns_suffix                        = string
    description                       = string
    visibility                        = string
    private_visibility_config_networks = list(string)
    labels                            = map(string)
  }))
}

variable "dns_forwarding_policies" {
  description = "Map of DNS forwarding policies to create"
  type = map(object({
    project_id                = string
    policy_name              = string
    network_self_link        = string
    enable_inbound_forwarding = bool
    enable_logging           = bool
    description              = string
    forwarding_zones = list(object({
      name        = string
      dns_name    = string
      description = string
      target_name_servers = list(object({
        ipv4_address = string
      }))
    }))
  }))
}