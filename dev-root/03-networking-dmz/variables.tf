variable "dmz_project_id" {
  description = "The DMZ host project ID"
  type        = string
}

variable "billing_account" {
  description = "The billing account ID"
  type        = string
}

variable "org_id" {
  description = "The organization ID"
  type        = string
}

variable "dmz_subnets" {
  description = "Map of DMZ subnets to create"
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