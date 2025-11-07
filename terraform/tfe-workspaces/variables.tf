variable "tfe_token" {
  description = "Terraform Enterprise API token"
  type        = string
  sensitive   = true
}

variable "tfe_organization" {
  description = "Terraform Enterprise organization name"
  type        = string
  default     = "your-tfe-organization"
}

variable "github_repo" {
  description = "GitHub repository identifier (org/repo)"
  type        = string
  default     = "your-org/GCP-Network-Modules"
}

variable "oauth_token_id" {
  description = "OAuth token ID for GitHub VCS integration"
  type        = string
}

variable "gcp_credentials" {
  description = "GCP service account credentials JSON"
  type        = string
  sensitive   = true
}

variable "gcp_project_id" {
  description = "GCP project ID for OIDC authentication"
  type        = string
}

variable "billing_account_id" {
  description = "GCP billing account ID"
  type        = string
  default     = null
}

variable "organization_id" {
  description = "GCP organization ID"
  type        = string
  default     = null
}