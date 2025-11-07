variable "firewall_rules" {
  description = "Map of firewall rules to create"
  type = map(object({
    name          = string
    direction     = string
    priority      = number
    action        = string
    protocol      = string
    ports         = list(string)
    source_ranges = list(string)
    target_tags   = list(string)
    description   = string
  }))
}