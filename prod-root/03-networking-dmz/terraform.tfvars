dmz_subnets = {
  dmz_primary = {
    name                     = "prod-dmz-subnet"
    cidr_block              = "10.40.0.0/24"
    region                  = "us-central1"
    private_ip_google_access = true
    description             = "DMZ subnet for dev environment"
  }
}