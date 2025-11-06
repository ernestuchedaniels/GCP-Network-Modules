variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "policy_name" {
  description = "Name of the DNS policy"
  type        = string
}

variable "network_self_link" {
  description = "Self-link of the VPC network"
  type        = string
}

variable "enable_inbound_forwarding" {
  description = "Enable inbound DNS forwarding"
  type        = bool
  default     = true
}

variable "enable_logging" {
  description = "Enable DNS logging"
  type        = bool
  default     = false
}

variable "description" {
  description = "Description of the DNS policy"
  type        = string
  default     = ""
}

variable "alternative_name_servers" {
  description = "Alternative name servers configuration"
  type = list(object({
    target_name_servers = list(object({
      ipv4_address    = string
      forwarding_path = string
    }))
  }))
  default = []
}

variable "forwarding_zones" {
  description = "DNS forwarding zones configuration"
  type = list(object({
    name        = string
    dns_name    = string
    description = string
    target_name_servers = list(object({
      ipv4_address = string
    }))
  }))
  default = []
}