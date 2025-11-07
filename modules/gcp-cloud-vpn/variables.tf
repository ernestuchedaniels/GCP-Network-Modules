variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "region" {
  description = "The region for VPN resources"
  type        = string
}

variable "vpn_gateway_name" {
  description = "Name of the HA VPN Gateway"
  type        = string
}

variable "network_self_link" {
  description = "Self link of the VPC network"
  type        = string
}

variable "tunnel_name_prefix" {
  description = "Prefix for VPN tunnel names"
  type        = string
}

variable "router_name" {
  description = "Name of the Cloud Router"
  type        = string
}

variable "peer_vpn_gateway_id" {
  description = "ID of the peer VPN gateway"
  type        = string
}

variable "shared_secrets" {
  description = "Shared secrets for VPN tunnels"
  type        = list(string)
}

variable "interface_ip_ranges" {
  description = "IP ranges for router interfaces"
  type        = list(string)
}

variable "peer_ip_addresses" {
  description = "Peer IP addresses for BGP"
  type        = list(string)
}

variable "peer_asn" {
  description = "Peer ASN for BGP"
  type        = number
}

variable "advertised_route_priority" {
  description = "Priority for advertised routes"
  type        = number
  default     = 100
}

variable "advertised_ip_ranges" {
  description = "IP ranges to advertise via BGP"
  type = list(object({
    range       = string
    description = string
  }))
  default = []
}