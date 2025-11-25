# Hybrid connectivity configuration
region = "us-central1"

# Cloud Routers configuration
cloud_routers = {
  test_router = {
    project_id  = "visa-gcp-network"
    name        = "test-router"
    network     = "test-vpc-1"
    region      = "us-central1"
    description = "Test router for import testing"
  }
}

# HA VPN Configuration - values required even though resources are commented out
enable_vpn              = false
vpn_region              = "us-central1"
peer_gateway_ip_0       = "138.88.241.198"
peer_gateway_ip_1       = "138.88.241.199"
vpn_shared_secrets      = ["changeme-secret1", "changeme-secret2"]
vpn_interface_ip_ranges = ["169.254.0.1/30", "169.254.0.5/30"]
vpn_peer_ip_addresses   = ["169.254.0.2", "169.254.0.6"]
vpn_peer_asn            = 65001
vpn_advertised_ip_ranges = []