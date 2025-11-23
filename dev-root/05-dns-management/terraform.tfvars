# DNS Zones configuration - Core VPC only
dns_zones = {
  # private_zone = {
  #   project_id                         = "visa-gcp-network"
  #   zone_name                         = "dev-private-zone"
  #   dns_suffix                        = "internal.visa.com."
  #   description                       = "Private DNS zone for Core VPC"
  #   visibility                        = "private"
  #   vpc_networks                      = ["CORE_VPC"]
  #   labels = {
  #     environment = "dev"
  #     purpose     = "internal-dns"
  #   }
  # }
}

# DNS Forwarding Policies configuration
dns_forwarding_policies = {
  # Core VPC - DNS Hub with on-prem forwarding
  # core_policy = {
  #   project_id                = "visa-gcp-network"
  #   policy_name              = "dev-core-dns-policy"
  #   network_self_link        = "CORE_VPC"
  #   enable_inbound_forwarding = true
  #   enable_logging           = true
  #   description              = "DNS hub policy for Core VPC"
  #   forwarding_zones = [
  #     {
  #       name        = "core-onprem-forward"
  #       dns_name    = "onprem.visa.com."
  #       description = "Forward on-prem queries"
  #       target_name_servers = [
  #         {
  #           ipv4_address = "10.0.1.10"  # On-prem DNS server
  #         }
  #       ]
  #     }
  #   ]
  # }
  # # DMZ VPC - DNS Spoke forwarding to Core VPC
  # dmz_policy = {
  #   project_id                = "visa-gcp-network"
  #   policy_name              = "dev-dmz-dns-policy"
  #   network_self_link        = "DMZ_VPC"
  #   enable_inbound_forwarding = false
  #   enable_logging           = true
  #   description              = "DNS spoke policy for DMZ VPC"
  #   forwarding_zones = [
  #     {
  #       name        = "internal-forward"
  #       dns_name    = "internal.visa.com."
  #       description = "Forward internal queries to Core VPC"
  #       target_name_servers = [
  #         {
  #           ipv4_address = "10.10.0.2"  # Core VPC DNS resolver (primary subnet)
  #         }
  #       ]
  #     },
  #     {
  #       name        = "dmz-onprem-forward"
  #       dns_name    = "onprem.visa.com."
  #       description = "Forward on-prem queries to Core VPC"
  #       target_name_servers = [
  #         {
  #           ipv4_address = "10.10.0.2"  # Core VPC DNS resolver (primary subnet)
  #         }
  #       ]
  #     }
  #   ]
  # }
}

# VPC Mappings - completely data-driven configuration
vpc_mappings = [
  # {
  #   name          = "CORE_VPC"
  #   vpc_self_link = "https://www.googleapis.com/compute/v1/projects/visa-gcp-network/global/networks/dev-shared-vpc"
  # },
  # {
  #   name          = "DMZ_VPC"
  #   vpc_self_link = "https://www.googleapis.com/compute/v1/projects/visa-gcp-network/global/networks/dev-dmz-vpc"
  # }
]