resource "google_dns_policy" "forwarding_policy" {
  project                   = var.project_id
  name                      = var.policy_name
  enable_inbound_forwarding = var.enable_inbound_forwarding
  enable_logging            = var.enable_logging
  description               = var.description

  networks {
    network_url = var.network_self_link
  }

  dynamic "alternative_name_server_config" {
    for_each = var.alternative_name_servers
    content {
      dynamic "target_name_servers" {
        for_each = alternative_name_server_config.value.target_name_servers
        content {
          ipv4_address    = target_name_servers.value.ipv4_address
          forwarding_path = target_name_servers.value.forwarding_path
        }
      }
    }
  }
}

resource "google_dns_managed_zone" "forwarding_zone" {
  for_each    = { for idx, zone in var.forwarding_zones : zone.name => zone }
  project     = var.project_id
  name        = each.value.name
  dns_name    = each.value.dns_name
  description = each.value.description
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = var.network_self_link
    }
  }

  forwarding_config {
    dynamic "target_name_servers" {
      for_each = each.value.target_name_servers
      content {
        ipv4_address = target_name_servers.value.ipv4_address
      }
    }
  }
}