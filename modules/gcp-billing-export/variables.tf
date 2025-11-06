variable "billing_account_id" {
  description = "The billing account ID"
  type        = string
}

variable "host_project_id" {
  description = "The host project ID where BigQuery dataset will reside"
  type        = string
}

variable "dataset_name" {
  description = "Name of the BigQuery dataset"
  type        = string
}

variable "network_team_label_key" {
  description = "Label key to filter network team resources (e.g., 'team')"
  type        = string
  default     = "team"
}