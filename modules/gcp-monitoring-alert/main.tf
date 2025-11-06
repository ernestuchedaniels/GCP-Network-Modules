resource "google_monitoring_alert_policy" "bgp_down_alert" {
  project      = var.project_id
  display_name = "BGP Session Down - ${var.router_name}"
  combiner     = "OR"
  enabled      = true

  conditions {
    display_name = "BGP Session Status Down"
    condition_threshold {
      filter          = "resource.type=\"gce_router\" AND resource.labels.router_id=\"${var.router_name}\" AND resource.labels.region=\"${var.region}\" AND metric.type=\"cloudrouter.googleapis.com/router/bgp_session_status\""
      duration        = "300s"
      comparison      = "COMPARISON_EQUAL"
      threshold_value = 1

      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MEAN"
      }
    }
  }

  notification_channels = [var.notification_channel]

  alert_strategy {
    auto_close = "1800s"
  }
}