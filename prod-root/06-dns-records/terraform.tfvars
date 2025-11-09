# DNS Records configuration - Super simple for developers
dns_records = {
  api_record = {
    project_id   = "visa-gcp-network"
    dns_suffix   = "internal.visa.com."  # Domain developers know
    record_name  = "api"                  # Just the record name!
    type         = "A"
    ttl          = 300
    rrdatas      = ["10.10.1.10"]  # A record: IP addresses
  }
  web_record = {
    project_id   = "visa-gcp-network"
    dns_suffix   = "internal.visa.com."
    record_name  = "web"                  # Just the record name!
    type         = "A"
    ttl          = 300
    rrdatas      = ["10.10.0.10"]  # A record: IP addresses
  }
}