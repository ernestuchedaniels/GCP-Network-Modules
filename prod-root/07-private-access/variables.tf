variable "service_attachment_uri" {
  description = "URI of the service attachment for PSC"
  type        = string
}

variable "peering_network_url" {
  description = "URL of the network to peer with"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}