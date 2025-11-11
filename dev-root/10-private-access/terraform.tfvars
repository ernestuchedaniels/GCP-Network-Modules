# PSC Endpoints - Third-party service attachments only
# Note: Google API bundles (all-apis) require global forwarding rules
# and cannot be used with this regional PSC module
psc_endpoints = {
  # Example: Third-party service (requires producer service attachment)
  # custom-service = {
  #   app_name              = "web"
  #   service_attachment_uri = "projects/producer-project/regions/us-central1/serviceAttachments/my-service"
  # }
}