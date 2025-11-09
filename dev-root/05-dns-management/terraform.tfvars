# DNS Zones configuration
dns_zones = {
  private_zone = {
    project_id                         = "visa-gcp-network"
    zone_name                         = "dev-private-zone"
    dns_suffix                        = "internal.visa.com."
    description                       = "Private DNS zone for dev environment"
    visibility                        = "private"
    # VPC visibility automatically includes all available VPCs
    labels = {
      environment = "dev"
      purpose     = "internal-dns"
    }
  }
}

# DNS Forwarding Policies configuration
dns_forwarding_policies = {
  core_policy = {
    project_id                = "visa-gcp-network"
    policy_name              = "dev-core-dns-policy"
    network_self_link        = "CORE_VPC"
    enable_inbound_forwarding = true
    enable_logging           = true
    description              = "DNS forwarding policy for Core VPC"
    forwarding_zones = [
      {
        name        = "internal-forward"
        dns_name    = "internal.visa.com."
        description = "Forward internal queries"
        target_name_servers = [
          {
            ipv4_address = "8.8.8.8"
          }
        ]
      }
    ]
  }
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
        ]
      }
    ]
  }
}