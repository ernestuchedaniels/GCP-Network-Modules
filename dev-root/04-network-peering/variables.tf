variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "vpc_peering_connections" {
  description = "Map of VPC peering connections to create"
  type = map(object({
    peering_name         = string
    local_vpc_link       = string
    peer_vpc_link        = string
    import_custom_routes = bool
    export_custom_routes = bool
  }))
}