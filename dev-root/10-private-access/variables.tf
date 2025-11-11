variable "psc_google_apis" {
  description = "Map of Google API PSC endpoints (global)"
  type = map(object({
    target = string  # Google API bundle (e.g., all-apis, vpc-sc)
  }))
  default = {}
}

variable "psc_service_attachments" {
  description = "Map of third-party PSC service attachments (regional)"
  type = map(object({
    app_name = string  # Subnet to deploy in (web, db, api, cache, lb)
    target   = string  # Service attachment URI
  }))
  default = {}
}
