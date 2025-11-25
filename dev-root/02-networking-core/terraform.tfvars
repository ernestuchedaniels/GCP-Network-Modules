# All VPCs managed through single for_each
vpcs = {
  main_vpc = {
    project_id              = "visa-gcp-network"
    network_name            = "dev-shared-vpc"
    auto_create_subnetworks = false
    routing_mode            = "REGIONAL"
    description             = "Shared VPC for dev environment"
  }
}

# Name overrides for zero-downtime migration (empty for now)
subnet_name_overrides = {}

# Test change for dev-02-networking-core workspace
subnets = {
 web = {
    app_name                 = "web"
    cidr_block              = "10.10.0.0/24"
    region                  = "us-central1"
    vpc_key                 = "main_vpc"
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
  api = {
    app_name                 = "api"
    cidr_block              = "10.10.1.0/24"
    region                  = "us-central1"
    vpc_key                 = "main_vpc"
    private_ip_google_access = true
    description             = "Secondary subnet for dev environment"
    secondary_ranges        = []
  }
  database = {
    app_name                 = "db"
    cidr_block              = "10.10.2.0/24"
    region                  = "us-central1"
    vpc_key                 = "main_vpc"
    private_ip_google_access = true
    description             = "Database subnet for dev environment"
    secondary_ranges        = []
  }
  cache = {
    app_name                 = "cache"
    cidr_block              = "10.10.3.0/24"
    region                  = "us-west1"
    vpc_key                 = "main_vpc"
    private_ip_google_access = true
    description             = "Cache subnet for dev environment"
    secondary_ranges        = []
  }
  lb = {
    app_name                 = "lb"
    cidr_block              = "10.10.4.0/24"
    region                  = "us-west1"
    vpc_key                 = "main_vpc"
    private_ip_google_access = true
    description             = "Load balancer subnet for dev environment"
    secondary_ranges        = []
  }
}