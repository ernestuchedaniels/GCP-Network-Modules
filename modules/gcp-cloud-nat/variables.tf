variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "region" {
  description = "The region for the NAT gateway"
  type        = string
}

variable "nat_name" {
  description = "Name of the Cloud NAT"
  type        = string
}

variable "router_name" {
  description = "Name of the Cloud Router"
  type        = string
}

variable "nat_ip_count" {
  description = "Number of static IPs to reserve for NAT"
  type        = number
  default     = 2
}

variable "source_subnet_cidrs" {
  description = "List of source subnets for NAT translation"
  type = list(object({
    subnet_name = string
  }))
}

variable "enable_logging" {
  description = "Enable NAT logging"
  type        = bool
  default     = true
}