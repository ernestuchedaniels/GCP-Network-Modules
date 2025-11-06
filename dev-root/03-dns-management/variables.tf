variable "onprem_dns_server_1" {
  description = "Primary on-premises DNS server IP"
  type        = string
}

variable "onprem_dns_server_2" {
  description = "Secondary on-premises DNS server IP"
  type        = string
}

variable "dns_records" {
  description = "Map of DNS records to create"
  type = map(object({
    name    = string
    type    = string
    ttl     = number
    rrdatas = list(string)
  }))
}