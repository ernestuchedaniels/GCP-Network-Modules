# DNS Records configuration
dns_records = {
  api_record = {
    project_id = "visa-gcp-network"
    zone_key   = "private_zone"
    name       = "api.internal.visa.com."
    type       = "A"
    ttl        = 300
    rrdatas    = ["10.30.1.10"]
  }
  web_record = {
    project_id = "visa-gcp-network"
    zone_key   = "private_zone"
    name       = "web.internal.visa.com."
    type       = "A"
    ttl        = 300
    rrdatas    = ["10.30.0.10"]
  }
}