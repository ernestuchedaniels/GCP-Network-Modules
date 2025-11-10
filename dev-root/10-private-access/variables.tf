variable "psc_endpoints" {
  description = "Map of PSC endpoints to create"
  type = map(object({
    name                   = string
    app_name              = string
    #service_attachment_uri = string
    region                = string
    description           = string
    labels                = map(string)
  }))
}

variable "peering_network_url" {
  description = "URL of the peer network for VPC peering"
  type        = string
}