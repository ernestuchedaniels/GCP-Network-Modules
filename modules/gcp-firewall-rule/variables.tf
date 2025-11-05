variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "network_link" {
  description = "The self-link of the VPC network"
  type        = string
}

variable "rule_name" {
  description = "Name of the firewall rule"
  type        = string
}

variable "source_ranges" {
  description = "List of source IP ranges"
  type        = list(string)
}

variable "direction" {
  description = "Direction of the firewall rule (INGRESS or EGRESS)"
  type        = string
  default     = "INGRESS"
}

variable "priority" {
  description = "Priority of the firewall rule"
  type        = number
  default     = 1000
}

variable "action" {
  description = "Action to take (allow or deny)"
  type        = string
  default     = "allow"
}

variable "protocol" {
  description = "Protocol for the rule (tcp, udp, icmp, etc.)"
  type        = string
  default     = "tcp"
}

variable "ports" {
  description = "List of ports to allow/deny"
  type        = list(string)
  default     = []
}

variable "target_tags" {
  description = "List of target tags"
  type        = list(string)
  default     = []
}

variable "source_tags" {
  description = "List of source tags"
  type        = list(string)
  default     = []
}

variable "description" {
  description = "Description of the firewall rule"
  type        = string
  default     = ""
}