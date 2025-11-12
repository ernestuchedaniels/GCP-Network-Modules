# Google API PSC Endpoints (global)
psc_google_apis = {
  allapis = {
    target     = "all-apis"
    ip_address = "10.10.100.1"
  }
}

# Google API PSC Endpoints (regional)
psc_google_apis_regional = {
  storage = {
    target        = "storage.us-west1.p.gcp-sa.net"
    region        = "us-west1"
    app_name      = "cache"
    global_access = true
  }
}

# Third-party PSC Service Attachments (regional)
psc_service_attachments = {
  # Example: Uncomment and configure when you have a producer service
  # custom-service = {
  #   app_name = "web"
  #   target   = "projects/producer-project/regions/us-central1/serviceAttachments/my-service
}
