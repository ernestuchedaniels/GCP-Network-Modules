variable "psc_endpoints" {
  description = "Map of third-party PSC endpoints (regional)"
  type = map(object({
    app_name              = string  # Subnet to deploy in (web, db, api, cache)
    service_attachment_uri = string  # Full service attachment URI (projects/...)
  }))
  default = {}
}

