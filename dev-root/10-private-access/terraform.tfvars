# PSC Endpoints for Google Services - Ultra simple configuration
psc_endpoints = {
  storage = {
    app_name              = "web"
    service_attachment_uri = "projects/gce-gg-prod/regions/us-central1/serviceAttachments/gcs-us-central1-psc"
  }
  bigquery = {
    app_name              = "db"
    service_attachment_uri = "projects/bigquery-p4sa-prod/regions/us-central1/serviceAttachments/bq-us-central1-psc"
  }
}