variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "zone_id" {
  description = "The ID of the DNS zone"
  type        = string
}

variable "record_name" {
  description = "Name of the DNS record"
  type        = string
}

variable "record_type" {
  description = "Type of the DNS record (A, AAAA, CNAME, etc.)"
  type        = string
}

variable "rrdatas" {
  description = "List of resource record data"
  type        = list(string)
}

variable "ttl" {
  description = "TTL for the DNS record"
  type        = number
  default     = 300
}