dmz_subnets = {
  dmz_primary = {
    app_name                 = "proxy"
    cidr_block              = "10.20.0.0/24"
    region                  = "us-central1"
    private_ip_google_access = true
    description             = "DMZ subnet for dev environment"
    secondary_ranges        = []
    # secondary_ranges = [
    #   {
    #     range_name    = "pods"
    #     ip_cidr_range = "10.21.0.0/16"
    #   },
    #   {
    #     range_name    = "services"
    #     ip_cidr_range = "10.22.0.0/16"
    #   }
    # ]
  }
}