# DNS Zones configuration - Core VPC only
dns_zones = {
  private_zone = {
    project_id                         = "visa-gcp-network"
    zone_name                         = "dev-private-zone"
    dns_suffix                        = "internal.visa.com."
    description                       = "Private DNS zone for Core VPC"
    visibility                        = "private"
    vpc_networks                      = ["CORE_VPC"]
    labels = {
      environment = "dev"
      purpose     = "internal-dns"
    }
  }
}

# DNS Forwarding Policies configuration - DMZ VPC only
dns_forwarding_policies = {
  dmz_policy = {
    project_id                = "visa-gcp-network"
    policy_name              = "dev-dmz-dns-policy"
    network_self_link        = "DMZ_VPC"
    enable_inbound_forwarding = true
    enable_logging           = true
    description              = "DNS forwarding policy for DMZ VPC"
    forwarding_zones = [
      {
        name        = "internal-forward"
        dns_name    = "internal.visa.com."
        description = "Forward internal queries"
        target_name_servers = [
          {
            ipv4_address = "8.8.8.8"
          }
          # Multiple DNS servers example:
          # {
          #   ipv4_address = "8.8.4.4"
          # },
          # {
          #   ipv4_address = "1.1.1.1"
          # }
        ]
      }
    ]
  }
}