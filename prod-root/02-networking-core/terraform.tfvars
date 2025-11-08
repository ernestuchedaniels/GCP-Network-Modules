subnets = {
  primary = {
    app_name                 = "web"
    cidr_block              = "10.30.0.0/24"
    region                  = "us-central1"
    private_ip_google_access = true
    description             = "Primary subnet for prod environment"
    secondary_ranges = [
      {
        range_name    = "pods"
        ip_cidr_range = "10.31.0.0/16"
      },
      {
        range_name    = "services"
        ip_cidr_range = "10.32.0.0/16"
      }
    ]
  }
}