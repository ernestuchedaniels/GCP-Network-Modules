variable "region" {
  description = "The region for VPN resources"
  type        = string
}

variable "vpn_shared_secrets" {
  description = "Shared secrets for VPN tunnels"
  type        = list(string)
}

variable "core_interface_ip_ranges" {
  description = "IP ranges for Core router interfaces"
  type        = list(string)
}

variable "dmz_interface_ip_ranges" {
  description = "IP ranges for DMZ router interfaces"
  type        = list(string)
}

variable "core_peer_ip_addresses" {
  description = "Peer IP addresses for Core BGP"
  type        = list(string)
}

variable "dmz_peer_ip_addresses" {
  description = "Peer IP addresses for DMZ BGP"
  type        = list(string)
}

variable "core_asn" {
  description = "ASN for Core VPC"
  type        = number
}

variable "dmz_asn" {
  description = "ASN for DMZ VPC"
  type        = number
}

variable "nat_ip_count" {
  description = "Number of static IPs for NAT"
  type        = number
}

variable "core_subnet_cidrs" {
  description = "Core subnet CIDRs for NAT translation"
  type = list(object({
    subnet_name = string
  }))
}