variable "psc_google_apis" {
  description = "Map of Google API PSC endpoints (global)"
  type = map(object({
    target     = string  # Google API bundle (e.g., all-apis, vpc-sc)
    ip_address = string  # Internal IP address for the endpoint
  }))
  default = {}
}

variable "psc_google_apis_regional" {
  description = "Map of regional Google API PSC endpoints"
  type = map(object({
    target        = string  # Google API service connection URI (e.g., storage.us-west1.p.gcp-sa.net)
    region        = string  # GCP region
    app_name      = string  # Subnet to deploy in (web, db, api, cache, lb)
    global_access = optional(bool, false)  # Enable global access
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
