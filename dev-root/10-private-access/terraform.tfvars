# PSC Endpoints configuration
psc_endpoints = {
  storage_endpoint = {
    name                   = "dev-storage-psc"
    app_name              = "web"  # Uses web app subnet
    #service_attachment_uri = "projects/service-networking/regions/us-central1/serviceAttachments/psc-ilb-consumer-service-attachment"
    region                = "us-central1"
    description           = "PSC endpoint for Google Cloud Storage"
    labels = {
      environment = "dev"
      service     = "storage"
    }
  }
  sql_endpoint = {
    name                   = "dev-sql-psc"
    app_name              = "db"  # Uses db app subnet
    #service_attachment_uri = "projects/service-networking/regions/us-central1/serviceAttachments/psc-ilb-consumer-service-attachment"
    region                = "us-central1"
    description           = "PSC endpoint for Cloud SQL"
    labels = {
      environment = "dev"
      service     = "sql"
    }
  }
}