variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "hub_self_link" {
  description = "The self-link of the NCC hub"
  type        = string
}

variable "vpc_self_link" {
  description = "The self-link of the VPC network"
  type        = string
}

variable "spoke_name" {
  description = "Name of the NCC spoke"
  type        = string
}

variable "location" {
  description = "Location for the spoke"
  type        = string
  default     = "global"
}

variable "description" {
  description = "Description of the NCC spoke"
  type        = string
  default     = ""
}

variable "labels" {
  description = "Labels to apply to the spoke"
  type        = map(string)
  default     = {}
}