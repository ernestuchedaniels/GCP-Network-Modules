variable "primary_dev_cidr" {
  description = "CIDR block for primary subnet"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "pods_cidr" {
  description = "CIDR block for pods secondary range"
  type        = string
  default     = "10.21.0.0/16"
}

variable "services_cidr" {
  description = "CIDR block for services secondary range"
  type        = string
  default     = "10.22.0.0/16"
}