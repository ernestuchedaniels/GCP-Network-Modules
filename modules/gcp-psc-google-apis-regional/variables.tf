variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "endpoint_name" {
  description = "Name of the PSC endpoint"
  type        = string
}

variable "region" {
  description = "The GCP region for the endpoint"
  type        = string
}

variable "network" {
  description = "The self-link of the VPC network"
  type        = string
}

variable "subnetwork" {
  description = "The self-link of the subnetwork"
  type        = string
}

variable "target" {
  description = "The Google API service (e.g., storage.us-west1.rep.googleapis.com)"
  type        = string
}

variable "global_access" {
  description = "Enable global access for the endpoint"
  type        = bool
  default     = false
}
