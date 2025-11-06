variable "onprem_dns_server_1" {
  description = "Primary on-premises DNS server IP"
  type        = string
  default     = "192.168.1.10"
}

variable "onprem_dns_server_2" {
  description = "Secondary on-premises DNS server IP"
  type        = string
  default     = "192.168.1.11"
}