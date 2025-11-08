firewall_rules = {
  allow_internal = {
    name      = "prod-allow-internal"
    direction = "INGRESS"
    priority  = 1000
    source_ranges = ["10.10.0.0/16"]
    target_tags = ["internal"]
    allowed = [{
      protocol = "tcp"
      ports    = ["22", "80", "443"]
    }]
  }
}