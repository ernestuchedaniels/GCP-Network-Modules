variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "local_vpc_link" {
  description = "The self-link of the local VPC network"
  type        = string
}

variable "peer_vpc_link" {
  description = "The self-link of the peer VPC network"
  type        = string
}

variable "peering_name" {
  description = "Name of the VPC peering connection"
  type        = string
}

variable "import_custom_routes" {
  description = "Whether to import custom routes from peer network"
  type        = bool
  default     = false
}

variable "export_custom_routes" {
  description = "Whether to export custom routes to peer network"
  type        = bool
  default     = false
}