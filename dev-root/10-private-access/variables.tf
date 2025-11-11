variable "google_api_endpoints" {
  description = "Map of Google API PSC endpoints (global)"
  type = map(object({
    service_bundle = string  # Google API bundle (e.g., all-apis)
  }))
  default = {}
}

variable "psc_endpoints" {
  description = "Map of third-party PSC endpoints (regional)"
  type = map(object({
    app_name              = string  # Subnet to deploy in (web, db, api, cache)
    service_attachment_uri = string  # Full service attachment URI (projects/...)
  }))
  default = {}
}

