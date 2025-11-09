variable "import_custom_routes" {
  description = "Whether to import custom routes from peer VPC"
  type        = bool
  default     = true
}

variable "export_custom_routes" {
  description = "Whether to export custom routes to peer VPC"
  type        = bool
  default     = true
}