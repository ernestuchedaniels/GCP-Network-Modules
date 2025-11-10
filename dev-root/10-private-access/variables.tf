variable "psc_endpoints" {
  description = "Map of PSC endpoints to create for Google services"
  type = map(object({
    app_name              = string
    service_attachment_uri = string
  }))
}

