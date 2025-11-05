resource "google_compute_firewall" "rule" {
  project       = var.project_id
  name          = var.rule_name
  network       = var.network_link
  direction     = var.direction
  priority      = var.priority
  source_ranges = var.source_ranges
  target_tags   = var.target_tags
  source_tags   = var.source_tags
  description   = var.description

  dynamic "allow" {
    for_each = var.action == "allow" ? [1] : []
    content {
      protocol = var.protocol
      ports    = var.ports
    }
  }

  dynamic "deny" {
    for_each = var.action == "deny" ? [1] : []
    content {
      protocol = var.protocol
      ports    = var.ports
    }
  }
}