variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "subnet_link" {
  description = "The self-link of the subnet"
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

variable "service_attachment_uri" {
  description = "URI of the service attachment"
  type        = string
  default     = null
}

variable "region" {
  description = "The region where the endpoint will be created"
  type        = string
}

variable "ip_address" {
  description = "Internal IP address for the endpoint (optional)"
  type        = string
  default     = null
}

variable "labels" {
  description = "Labels to apply to the endpoint"
  type        = map(string)
  default     = {}
}

variable "description" {
  description = "Description of the PSC endpoint"
  type        = string
  default     = ""
}