variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "endpoint_name" {
  description = "Name of the PSC endpoint"
  type        = string
}

variable "region" {
  description = "The region for the PSC endpoint"
  type        = string
}

variable "subnetwork" {
  description = "The self-link of the subnet"
  type        = string
}

variable "network" {
  description = "The self-link of the VPC network"
  type        = string
}

variable "target" {
  description = "The service attachment URI"
  type        = string
}
