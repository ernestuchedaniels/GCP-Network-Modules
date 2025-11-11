variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "network_link" {
  description = "The self-link of the network"
  type        = string
}

variable "endpoint_name" {
  description = "Name of the PSC endpoint"
  type        = string
}

variable "service_bundle" {
  description = "Google API bundle (e.g., all-apis)"
  type        = string
}

variable "labels" {
  description = "Labels to apply to the endpoint"
  type        = map(string)
  default     = {}
}
