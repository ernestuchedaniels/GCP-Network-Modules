# Hybrid connectivity configuration
region = "us-central1"

# HA VPN Configuration - Disabled: peer IPs must be public, not RFC1918 private IPs
enable_vpn              = false
vpn_region              = "us-central1"
peer_gateway_ip_0       = "203.0.113.1"
peer_gateway_ip_1       = "203.0.113.2"
vpn_shared_secrets      = ["changeme-secret1", "changeme-secret2"]
vpn_interface_ip_ranges = ["169.254.0.1/30", "169.254.0.5/30"]
vpn_peer_ip_addresses   = ["169.254.0.2", "169.254.0.6"]
vpn_peer_asn            = 65001
vpn_advertised_ip_ranges = [
  {
    range       = "10.10.0.0/16"
    description = "dev-shared-vpc CIDR"
  }
]