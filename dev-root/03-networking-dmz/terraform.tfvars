dmz_subnets = {
  dmz_primary = {
    name                     = "dev-dmz-subnet"
    cidr_block              = "10.20.0.0/24"
    region                  = "us-central1"
    private_ip_google_access = true
    description             = "DMZ subnet for dev environment"
  }
}