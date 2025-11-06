terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.45"
    }
  }
}

locals {
  environment = "dev"
}

# Read outputs from previous stages
data "terraform_remote_state" "project_setup" {
  backend = "local"
  config = {
    path = "../01-project-setup/terraform.tfstate"
  }
}

data "terraform_remote_state" "networking_core" {
  backend = "local"
  config = {
    path = "../02-networking-core/terraform.tfstate"
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