variable "primary_prod_cidr" {
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
  default     = "10.31.0.0/16"
}

variable "services_cidr" {
  description = "CIDR block for services secondary range"
  type        = string
  default     = "10.32.0.0/16"
}