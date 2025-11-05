variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "hub_name" {
  description = "Name of the NCC hub"
  type        = string
}

variable "description" {
  description = "Description of the NCC hub"
  type        = string
  default     = ""
}

variable "labels" {
  description = "Labels to apply to the hub"
  type        = map(string)
  default     = {}
}