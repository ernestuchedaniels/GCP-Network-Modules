# DNS Records configuration - Super simple for developers
dns_records = {
  # api_record = {
  #   project_id   = "visa-gcp-network"
  #   dns_suffix   = "internal.visa.com."  # Domain developers know
  #   record_name  = "api"                  # Just the record name!
  #   type         = "A"
  #   rrdatas      = ["10.10.1.10"]  # A record: IP addresses
  # }
  # web_record = {
  #   project_id   = "visa-gcp-network"
  #   dns_suffix   = "internal.visa.com."
  #   record_name  = "web"                  # Just the record name!
  #   type         = "A"
  #   rrdatas      = ["10.10.0.10"]  # A record: IP addresses
  # }
  # db_record = {
  #   project_id   = "visa-gcp-network"
  #   dns_suffix   = "internal.visa.com."
  #   record_name  = "db"                  # Just the record name!
  #   type         = "A"
  #   rrdatas      = ["10.10.2.10"]  # A record: IP addresses
  # }
  # Example CNAME record (commented):
  # app_cname = {
  #   project_id   = "visa-gcp-network"
  #   dns_suffix   = "internal.visa.com."
  #   record_name  = "app"                  # Just "app", not full FQDN
  #   type         = "CNAME"
  #   rrdatas      = ["api.internal.visa.com."]  # CNAME: target domain
  # }
  test_api_record = {
    project_id   = "visa-gcp-network"
    dns_suffix   = "test1.internal."
    record_name  = "api"
    type         = "A"
    rrdatas      = ["10.1.0.10"]
  }
  test_web_record = {
    project_id   = "visa-gcp-network"
    dns_suffix   = "test1.internal."
    record_name  = "web"
    type         = "A"
    rrdatas      = ["10.1.0.20"]
  }
  test_db_record = {
    project_id   = "visa-gcp-network"
    dns_suffix   = "test2.internal."
    record_name  = "db"
    type         = "A"
    rrdatas      = ["10.2.0.10"]
  }
  test_app_cname = {
    project_id   = "visa-gcp-network"
    dns_suffix   = "test2.internal."
    record_name  = "app"
    type         = "CNAME"
    rrdatas      = ["api.test1.internal."]
  }
}