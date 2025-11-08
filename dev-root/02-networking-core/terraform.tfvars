# Test change for dev-02-networking-core workspace
# Second test to verify run ordering in TFE GUI
subnets = {
  frontend_subnet = {
    app_name                 = "web"
    cidr_block              = "10.10.0.0/24"
    region                  = "us-central1"
    private_ip_google_access = true
    description             = "Frontend subnet for dev environment"
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
  backend_subnet = {
    app_name                 = "api"
    cidr_block              = "10.10.1.0/24"
    region                  = "us-central1"
    private_ip_google_access = true
    description             = "Backend subnet for dev environment"
    secondary_ranges        = []
  }
  database_subnet = {
    app_name                 = "db"
    cidr_block              = "10.10.2.0/24"
    region                  = "us-central1"
    private_ip_google_access = true
    description             = "Database subnet for dev environment"
    secondary_ranges        = []
  }
}