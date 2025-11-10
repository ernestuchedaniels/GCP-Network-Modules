# PSC Endpoints - Supports both architectures
# Fixed network_link to use correct output name
psc_endpoints = {
  # Architecture 1: Google APIs (using published service attachment)
  google-apis = {
    app_name              = "web"
    service_attachment_uri = "projects/service-networking/regions/us-central1/serviceAttachments/psc-googleapis-com"
  }
  
  # Cloud SQL endpoint
  cloud-sql = {
    app_name              = "api"
    service_attachment_uri = "projects/service-networking/regions/us-central1/serviceAttachments/psc-cloud-sql"
  }
  
  # BigQuery endpoint
  bigquery = {
    app_name              = "db"
    service_attachment_uri = "projects/service-networking/regions/us-central1/serviceAttachments/psc-bigquery"
  }
  
  # Cloud Storage endpoint
  storage = {
    app_name              = "cache"
    service_attachment_uri = "projects/service-networking/regions/us-central1/serviceAttachments/psc-cloud-storage"
  }
  
  # Architecture 2: Third-party services (requires producer)
  # custom_service = {
  #   app_name              = "db"
  #   service_attachment_uri = "projects/producer-project/regions/us-central1/serviceAttachments/my-service"
  # }
}