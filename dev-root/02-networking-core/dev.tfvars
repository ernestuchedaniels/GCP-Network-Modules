subnets = {
  primary = {
    name                     = "dev-primary-subnet"
    cidr_block              = "10.10.0.0/24"
    region                  = "us-central1"
    private_ip_google_access = true
    description             = "Primary subnet for dev environment"
    secondary_ranges = [
      {
        range_name    = "pods"
        ip_cidr_range = "10.11.0.0/16"
      },
      {
        range_name    = "services"
        ip_cidr_range = "10.12.0.0/16"
      }
    ]
  }
  secondary = {
    name                     = "dev-secondary-subnet"
    cidr_block              = "10.10.1.0/24"
    region                  = "us-central1"
    private_ip_google_access = true
    description             = "Secondary subnet for dev environment"
    secondary_ranges        = []
  }
}