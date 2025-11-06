variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "notification_channel_id" {
  description = "Notification channel ID for alerts"
  type        = string
}