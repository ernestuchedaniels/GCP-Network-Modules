variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "router_name" {
  description = "Name of the cloud router to monitor"
  type        = string
}

variable "region" {
  description = "Region of the cloud router"
  type        = string
}

variable "notification_channel" {
  description = "Notification channel ID for alerts"
  type        = string
}