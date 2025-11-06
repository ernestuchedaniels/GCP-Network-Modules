variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    name                     = string
    cidr_block              = string
    region                  = string
    private_ip_google_access = bool
    description             = string
    secondary_ranges = list(object({
      range_name    = string
      ip_cidr_range = string
    }))
  }))
}