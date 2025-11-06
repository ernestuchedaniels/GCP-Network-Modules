variable "app_project_id" {
  description = "The service project ID for applications"
  type        = string
}

variable "billing_account" {
  description = "The billing account ID"
  type        = string
}

variable "org_id" {
  description = "The organization ID"
  type        = string
  default     = null
}