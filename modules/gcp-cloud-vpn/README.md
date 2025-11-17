# GCP HA VPN Module

Creates a highly available VPN connection with Cloud Router and BGP peering.

## Features

- HA VPN Gateway with 2 interfaces for 99.99% SLA
- External VPN Gateway support for on-premises connections
- Automatic BGP advertise mode selection (CUSTOM when custom routes provided, DEFAULT otherwise)
- 2 VPN tunnels with IPsec encryption
- BGP peering with custom route advertisement
- Router interfaces with link-local IP addressing

## Requirements

- **Public IP addresses** for peer gateway (RFC1918 private IPs not supported for standard HA VPN)
- Peer gateway must support IPsec and BGP
- Cloud Router must exist before creating VPN

## Usage

```hcl
module "ha_vpn" {
  source = "./modules/gcp-cloud-vpn"

  project_id           = "my-project-id"
  region               = "us-central1"
  vpn_gateway_name     = "my-vpn-gateway"
  network_self_link    = "projects/my-project/global/networks/my-vpc"
  tunnel_name_prefix   = "my-vpn"
  router_name          = "my-cloud-router"
  peer_vpn_gateway_id  = google_compute_external_vpn_gateway.peer.id
  shared_secrets       = ["secret1", "secret2"]
  interface_ip_ranges  = ["169.254.0.1/30", "169.254.0.5/30"]
  peer_ip_addresses    = ["169.254.0.2", "169.254.0.6"]
  peer_asn             = 65001
  advertised_ip_ranges = [
    {
      range       = "10.10.0.0/16"
      description = "VPC CIDR"
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| region | The region for VPN resources | `string` | - | yes |
| vpn_gateway_name | Name of the HA VPN Gateway | `string` | - | yes |
| network_self_link | Self link of the VPC network | `string` | - | yes |
| tunnel_name_prefix | Prefix for VPN tunnel names | `string` | - | yes |
| router_name | Name of the Cloud Router | `string` | - | yes |
| peer_vpn_gateway_id | ID of the peer VPN gateway | `string` | - | yes |
| shared_secrets | Shared secrets for VPN tunnels (2 required) | `list(string)` | - | yes |
| interface_ip_ranges | IP ranges for router interfaces (2 required) | `list(string)` | - | yes |
| peer_ip_addresses | Peer IP addresses for BGP (2 required) | `list(string)` | - | yes |
| peer_asn | Peer ASN for BGP | `number` | - | yes |
| advertised_route_priority | Priority for advertised routes | `number` | `100` | no |
| advertised_ip_ranges | IP ranges to advertise via BGP | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpn_gateway_id | ID of the HA VPN Gateway |
| vpn_gateway_self_link | Self link of the HA VPN Gateway |
| tunnel_self_links | Self links of VPN tunnels |
| tunnel_names | Names of VPN tunnels |

## Notes

- BGP advertise mode is automatically set to CUSTOM when `advertised_ip_ranges` is provided
- Link-local IPs (169.254.0.0/16) are used for BGP peering
- Each tunnel connects to a different interface on the peer gateway for redundancy
- Shared secrets should be stored securely (use Terraform variables marked as sensitive)
