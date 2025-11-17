variable "region" {
  description = "GCP region for Cloud Routers"
  type        = string
}

variable "enable_vpn" {
  description = "Enable HA VPN"
  type        = bool
  default     = false
}

variable "vpn_region" {
  description = "GCP region for VPN resources"
  type        = string
  default     = "us-central1"
}

variable "peer_vpn_gateway_id" {
  description = "Peer VPN gateway ID"
  type        = string
  default     = ""
}

variable "vpn_shared_secrets" {
  description = "Shared secrets for VPN tunnels"
  type        = list(string)
  default     = []
  sensitive   = true
}

variable "vpn_interface_ip_ranges" {
  description = "IP ranges for VPN router interfaces"
  type        = list(string)
  default     = []
}

variable "vpn_peer_ip_addresses" {
  description = "Peer IP addresses for BGP"
  type        = list(string)
  default     = []
}

variable "vpn_peer_asn" {
  description = "Peer ASN for BGP"
  type        = number
  default     = 65000
}

variable "vpn_advertised_ip_ranges" {
  description = "IP ranges to advertise via BGP"
  type = list(object({
    range       = string
    description = string
  }))
  default = []
}