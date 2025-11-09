variable "dns_records" {
  description = "Map of DNS records to create"
  type = map(object({
    project_id = string
    zone_key   = string
    name       = string
    type       = string
    ttl        = number
    rrdatas    = list(string)
  }))
}