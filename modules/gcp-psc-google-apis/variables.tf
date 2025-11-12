variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "endpoint_name" {
  description = "Name of the PSC endpoint (alphanumeric only, <20 chars)"
  type        = string
}

variable "network" {
  description = "The self-link of the VPC network"
  type        = string
}

variable "target" {
  description = "The Google API bundle (e.g., all-apis, vpc-sc)"
  type        = string
}

variable "ip_address" {
  description = "Internal IP address for the PSC endpoint"
  type        = string
}
