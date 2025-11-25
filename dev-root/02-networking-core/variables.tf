variable "vpcs" {
  description = "Map of VPCs to create"
  type = map(object({
    project_id              = string
    network_name            = string
    auto_create_subnetworks = bool
    routing_mode            = string
    description             = string
  }))
  default = {}
}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    app_name                 = string
    cidr_block              = string
    region                  = string
    vpc_key                 = string
    private_ip_google_access = bool
    description             = string
    secondary_ranges = list(object({
      range_name    = string
      ip_cidr_range = string
    }))
  }))
}

variable "subnet_name_overrides" {
  description = "Map of subnet name overrides for zero-downtime migration"
  type        = map(string)
  default     = {}
}

