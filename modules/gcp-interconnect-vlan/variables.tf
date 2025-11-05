variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "router_name" {
  description = "Name of the cloud router"
  type        = string
}

variable "region" {
  description = "The region where the interconnect will be created"
  type        = string
}

variable "interconnect_name" {
  description = "Name of the interconnect attachment"
  type        = string
}

variable "type" {
  description = "Type of interconnect attachment"
  type        = string
  default     = "PARTNER"
}

variable "edge_availability_domain" {
  description = "Edge availability domain"
  type        = string
  default     = "AVAILABILITY_DOMAIN_1"
}

variable "admin_enabled" {
  description = "Whether the attachment is enabled"
  type        = bool
  default     = true
}

variable "bandwidth" {
  description = "Bandwidth of the interconnect attachment"
  type        = string
  default     = "BPS_1G"
}

variable "description" {
  description = "Description of the interconnect attachment"
  type        = string
  default     = ""
}