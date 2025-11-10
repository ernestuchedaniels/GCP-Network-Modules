firewall_rules = {
  allow_internal = {
    name          = "dev-allow-internal"
    direction     = "INGRESS"
    priority      = 1000
    action        = "allow"
    protocol      = "tcp"
    ports         = ["22", "80", "443"]
    source_ranges = ["10.10.0.0/16"]
    target_tags   = ["internal"]
    description   = "Allow internal traffic on common ports"
  }
  allow_ssh = {
    name          = "dev-allow-ssh"
    direction     = "INGRESS"
    priority      = 1000
    action        = "allow"
    protocol      = "tcp"
    ports         = ["22"]
    source_ranges = ["0.0.0.0/0"]
    target_tags   = ["ssh"]
    description   = "Allow SSH from anywhere"
  }
}