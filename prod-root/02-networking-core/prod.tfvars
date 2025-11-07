subnets = {
  primary = {
    name                     = "prod-primary-subnet"
    cidr_block              = "10.20.0.0/24"
    region                  = "us-central1"
    private_ip_google_access = true
    description             = "Primary subnet for prod environment"
    secondary_ranges = [
      {
        range_name    = "pods"
        ip_cidr_range = "10.21.0.0/16"
      },
      {
        range_name    = "services"
        ip_cidr_range = "10.22.0.0/16"
      }
    ]
  }
  secondary = {
    name                     = "prod-secondary-subnet"
    cidr_block              = "10.20.1.0/24"
    region                  = "us-central1"
    private_ip_google_access = true
    description             = "Secondary subnet for prod environment"
    secondary_ranges        = []
  }
}