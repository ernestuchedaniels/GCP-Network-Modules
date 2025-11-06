output "alert_policy_id" {
  description = "The ID of the alert policy"
  value       = google_monitoring_alert_policy.bgp_down_alert.id
}