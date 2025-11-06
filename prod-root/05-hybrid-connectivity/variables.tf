variable "region" {
  description = "GCP region"
  type        = string
}

variable "asn_number" {
  description = "BGP ASN number"
  type        = number
}

variable "vlan_attachments" {
  description = "Map of VLAN attachments to create"
  type = map(object({
    name        = string
    region      = string
    type        = string
    bandwidth   = string
    description = string
  }))
}