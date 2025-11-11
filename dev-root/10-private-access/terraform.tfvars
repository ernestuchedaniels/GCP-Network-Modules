# PSC for Google APIs requires Private Google Access, not PSC endpoints
# Use Private Google Access on subnets instead

# Third-party PSC Endpoints (regional)
psc_endpoints = {
  # Example: Third-party service (requires producer service attachment)
  # custom-service = {
  #   app_name              = "web"
  #   service_attachment_uri = "projects/producer-project/regions/us-central1/serviceAttachments/my-service"
  # }
}