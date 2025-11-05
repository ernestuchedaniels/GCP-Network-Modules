variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "network_link" {
  description = "The self-link of the VPC network"
  type        = string
}

variable "region" {
  description = "The region where the router will be created"
  type        = string
}

variable "router_name" {
  description = "Name of the cloud router"
  type        = string
}

variable "description" {
  description = "Description of the cloud router"
  type        = string
  default     = ""
}

variable "bgp_asn" {
  description = "BGP ASN for the router"
  type        = number
  default     = 64512
}