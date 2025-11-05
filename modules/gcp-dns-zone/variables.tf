variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "zone_name" {
  description = "Name of the DNS zone"
  type        = string
}

variable "dns_suffix" {
  description = "DNS suffix for the zone"
  type        = string
}

variable "description" {
  description = "Description of the DNS zone"
  type        = string
  default     = ""
}

variable "visibility" {
  description = "Visibility of the DNS zone (public or private)"
  type        = string
  default     = "public"
}

variable "private_visibility_config_networks" {
  description = "List of VPC networks for private zone visibility"
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "Labels to apply to the DNS zone"
  type        = map(string)
  default     = {}
}