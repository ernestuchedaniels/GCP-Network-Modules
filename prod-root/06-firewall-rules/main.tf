terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "your-tfe-organization"
    workspaces {
      name = "prod-06-firewall-rules"
    }
  }
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.45"
    }
  }
}

locals {
  environment = "prod"
}

# Read outputs from previous stages
data "terraform_remote_state" "project_setup" {
  backend = "remote"
  config = {
    workspace = "prod-02-networking-core"
  }
}

data "terraform_remote_state" "networking_core" {
  backend = "remote"
  config = {
    workspace = "prod-02-networking-core"
  }
}

# Create Firewall Rules
module "firewall_rules" {
  source = "../../modules/gcp-firewall-rule"
  
  for_each = var.firewall_rules
  
  project_id     = data.terraform_remote_state.project_setup.outputs.host_project_id
  rule_name      = each.value.name
  network_link   = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  direction      = each.value.direction
  priority       = each.value.priority
  action         = each.value.action
  protocol       = each.value.protocol
  ports          = each.value.ports
  source_ranges  = each.value.source_ranges
  target_tags    = each.value.target_tags
  description    = each.value.description
}