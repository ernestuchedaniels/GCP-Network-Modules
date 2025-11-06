variable "vpc_cidr_range" {
  description = "CIDR range of the VPC for internal traffic"
  type        = string
  default     = "10.20.0.0/16"
}

variable "ssh_source_ranges" {
  description = "Source IP ranges allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}