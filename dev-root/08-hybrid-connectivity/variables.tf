variable "region" {
  description = "GCP region for Cloud Router"
  type        = string
}

variable "enable_vpn" {
  description = "Enable HA VPN"
  type        = bool
}

variable "vpn_region" {
  description = "GCP region for VPN resources"
  type        = string
}

variable "peer_gateway_ip_0" {
  description = "Peer VPN gateway interface 0 IP address"
  type        = string
}

variable "peer_gateway_ip_1" {
  description = "Peer VPN gateway interface 1 IP address"
  type        = string
}

variable "vpn_shared_secrets" {
  description = "Shared secrets for VPN tunnels"
  type        = list(string)
  sensitive   = true
}

variable "vpn_interface_ip_ranges" {
  description = "IP ranges for VPN router interfaces"
  type        = list(string)
}

variable "vpn_peer_ip_addresses" {
  description = "Peer IP addresses for BGP"
  type        = list(string)
}

variable "vpn_peer_asn" {
  description = "Peer ASN for BGP"
  type        = number
}

variable "vpn_advertised_ip_ranges" {
  description = "IP ranges to advertise via BGP"
  type = list(object({
    range       = string
    description = string
  }))
}