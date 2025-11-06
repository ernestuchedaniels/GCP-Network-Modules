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

# Allow Internal Traffic
module "allow_internal" {
  source = "../../modules/gcp-firewall-rule"
  
  project_id     = data.terraform_remote_state.project_setup.outputs.host_project_id
  rule_name      = "${local.environment}-allow-internal"
  network_link   = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  direction      = "INGRESS"
  priority       = 1000
  action         = "allow"
  protocol       = "all"
  source_ranges  = [var.vpc_cidr_range]
  description    = "Allow internal traffic within VPC"
}

# Allow SSH Access
module "allow_ssh" {
  source = "../../modules/gcp-firewall-rule"
  
  project_id     = data.terraform_remote_state.project_setup.outputs.host_project_id
  rule_name      = "${local.environment}-allow-ssh"
  network_link   = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  direction      = "INGRESS"
  priority       = 1000
  action         = "allow"
  protocol       = "tcp"
  ports          = ["22"]
  source_ranges  = var.ssh_source_ranges
  target_tags    = ["ssh-enabled"]
  description    = "Allow SSH access"
}

# Allow HTTP/HTTPS
module "allow_web" {
  source = "../../modules/gcp-firewall-rule"
  
  project_id     = data.terraform_remote_state.project_setup.outputs.host_project_id
  rule_name      = "${local.environment}-allow-web"
  network_link   = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  direction      = "INGRESS"
  priority       = 1000
  action         = "allow"
  protocol       = "tcp"
  ports          = ["80", "443"]
  source_ranges  = ["0.0.0.0/0"]
  target_tags    = ["web-server"]
  description    = "Allow HTTP/HTTPS traffic"
}

# Deny All Other Traffic (Explicit Deny)
module "deny_all" {
  source = "../../modules/gcp-firewall-rule"
  
  project_id     = data.terraform_remote_state.project_setup.outputs.host_project_id
  rule_name      = "${local.environment}-deny-all"
  network_link   = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  direction      = "INGRESS"
  priority       = 65534
  action         = "deny"
  protocol       = "all"
  source_ranges  = ["0.0.0.0/0"]
  description    = "Explicit deny all other traffic"
}