# PSC Endpoints - Supports both architectures
psc_endpoints = {
  # Architecture 1: Google APIs (using published service attachment)
  google_apis = {
    app_name              = "web"
    service_attachment_uri = "projects/service-networking/regions/us-central1/serviceAttachments/psc-googleapis-com"
  }
  
  # Architecture 2: Third-party services (requires producer)
  # custom_service = {
  #   app_name              = "db"
  #   service_attachment_uri = "projects/producer-project/regions/us-central1/serviceAttachments/my-service"
  # }
}