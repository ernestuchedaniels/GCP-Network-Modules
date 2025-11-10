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

