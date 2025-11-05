variable "project_id" {
  description = "The GCP project ID"
  type        = string
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "Project ID must be 6-30 characters, lowercase, alphanumeric with hyphens."
  }
}

variable "project_name" {
  description = "The display name of the project"
  type        = string
}

variable "org_id" {
  description = "The organization ID"
  type        = string
  default     = null
}

variable "folder_id" {
  description = "The folder ID to create the project in"
  type        = string
  default     = null
}

variable "billing_account" {
  description = "The billing account ID"
  type        = string
}

variable "host_project_id" {
  description = "The host project ID for shared VPC"
  type        = string
}

variable "auto_create_network" {
  description = "Whether to automatically create the default network"
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply to the project"
  type        = map(string)
  default     = {}
}