output "dashboard_id" {
  description = "The ID of the network monitoring dashboard"
  value       = module.network_dashboard.dashboard_id
}

output "alert_policy_id" {
  description = "The ID of the BGP alert policy"
  value       = module.bgp_alert.alert_policy_id
}