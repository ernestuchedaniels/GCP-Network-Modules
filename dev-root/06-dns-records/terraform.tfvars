# DNS Records configuration - Super simple for developers
dns_records = {
  api_record = {
    project_id   = "visa-gcp-network"
    dns_suffix   = "internal.visa.com."  # Domain developers know
    record_name  = "api"                  # Just the record name!
    type         = "A"
    rrdatas      = ["10.10.1.10"]  # A record: IP addresses
  }
  web_record = {
    project_id   = "visa-gcp-network"
    dns_suffix   = "internal.visa.com."
    record_name  = "web"                  # Just the record name!
    type         = "A"
    rrdatas      = ["10.10.0.10"]  # A record: IP addresses
  }
  db_record = {
    project_id   = "visa-gcp-network"
    dns_suffix   = "internal.visa.com."
    record_name  = "db"                  # Just the record name!
    type         = "A"
    rrdatas      = ["10.10.2.10"]  # A record: IP addresses
  }
  # Example CNAME record (commented):
  # app_cname = {
  #   project_id   = "visa-gcp-network"
  #   dns_suffix   = "internal.visa.com."
  #   record_name  = "app"                  # Just "app", not full FQDN
  #   type         = "CNAME"
  #   rrdatas      = ["api.internal.visa.com."]  # CNAME: target domain
  # }
}