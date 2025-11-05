variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "host_project_id" {
  description = "The host project ID for shared VPC"
  type        = string
}

variable "service_project_number" {
  description = "The service project number to attach to shared VPC"
  type        = string
}

variable "role" {
  description = "IAM role to assign"
  type        = string
  default     = "roles/compute.networkUser"
}