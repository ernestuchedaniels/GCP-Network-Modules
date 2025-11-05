variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "vpc_link" {
  description = "The self-link of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "region" {
  description = "The region where the subnet will be created"
  type        = string
}

variable "description" {
  description = "Description of the subnet"
  type        = string
  default     = ""
}

variable "private_ip_google_access" {
  description = "Whether to enable private Google access"
  type        = bool
  default     = true
}

variable "secondary_ranges" {
  description = "Secondary IP ranges for the subnet"
  type = list(object({
    range_name    = string
    ip_cidr_range = string
  }))
  default = []
}