# PSC Endpoints - Supports both architectures
# Using global all-apis bundle provides access to all Google APIs
# (BigQuery, Cloud SQL, Storage, etc.) through a single PSC endpoint
psc_endpoints = {
  # Google APIs endpoint (provides access to all Google APIs)
  all-google-apis = {
    app_name              = "web"
    service_attachment_uri = "all-apis"
  }
  
  # Architecture 2: Third-party services (requires producer)
  # custom_service = {
  #   app_name              = "db"
  #   service_attachment_uri = "projects/producer-project/regions/us-central1/serviceAttachments/my-service"
  # }
}