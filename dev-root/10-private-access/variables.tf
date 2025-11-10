variable "psc_endpoints" {
  description = "Map of PSC endpoints supporting both architectures: 1) Google APIs (vpc-sc, all-apis) 2) Third-party services (full service attachment URIs)"
  type = map(object({
    app_name              = string  # Subnet to deploy in (web, db, api, cache)
    service_attachment_uri = string  # Either Google bundle (vpc-sc) or full URI (projects/...)
  }))
}

