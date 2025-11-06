variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "asn_number" {
  description = "BGP ASN number"
  type        = number
  default     = 65000
}

variable "bandwidth" {
  description = "Interconnect bandwidth"
  type        = string
  default     = "BPS_1G"
}