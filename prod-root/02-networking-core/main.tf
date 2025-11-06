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

# Read outputs from 01-project-setup
data "terraform_remote_state" "project_setup" {
  backend = "local"
  config = {
    path = "../01-project-setup/terraform.tfstate"
  }
}

# Create VPC Network
module "main_vpc" {
  source = "../../modules/gcp-vpc"
  
  project_id              = data.terraform_remote_state.project_setup.outputs.host_project_id
  network_name            = "${local.environment}-shared-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  description             = "Shared VPC for ${local.environment} environment"
}

# Create Primary Subnet
module "primary_subnet" {
  source = "../../modules/gcp-subnet"
  
  project_id                = data.terraform_remote_state.project_setup.outputs.host_project_id
  subnet_name               = "${local.environment}-primary-subnet"
  cidr_block                = var.primary_prod_cidr
  region                    = var.region
  vpc_link                  = module.main_vpc.vpc_self_link
  private_ip_google_access  = true
  description               = "Primary subnet for ${local.environment} environment"
  
  secondary_ranges = [
    {
      range_name    = "pods"
      ip_cidr_range = var.pods_cidr
    },
    {
      range_name    = "services"
      ip_cidr_range = var.services_cidr
    }
  ]
}

# Create Firewall Rules
module "allow_internal" {
  source = "../../modules/gcp-firewall-rule"
  
  project_id     = data.terraform_remote_state.project_setup.outputs.host_project_id
  rule_name      = "${local.environment}-allow-internal"
  network_link   = module.main_vpc.vpc_self_link
  direction      = "INGRESS"
  priority       = 1000
  action         = "allow"
  protocol       = "all"
  source_ranges  = [var.primary_prod_cidr]
  description    = "Allow internal traffic within VPC"
}

module "allow_ssh" {
  source = "../../modules/gcp-firewall-rule"
  
  project_id     = data.terraform_remote_state.project_setup.outputs.host_project_id
  rule_name      = "${local.environment}-allow-ssh"
  network_link   = module.main_vpc.vpc_self_link
  direction      = "INGRESS"
  priority       = 1000
  action         = "allow"
  protocol       = "tcp"
  ports          = ["22"]
  source_ranges  = ["0.0.0.0/0"]
  target_tags    = ["ssh-enabled"]
  description    = "Allow SSH access"
}

# Create DNS Zone
module "private_dns_zone" {
  source = "../../modules/gcp-dns-zone"
  
  project_id  = data.terraform_remote_state.project_setup.outputs.host_project_id
  zone_name   = "${local.environment}-internal-zone"
  dns_suffix  = "${local.environment}.internal."
  description = "Private DNS zone for ${local.environment} environment"
  visibility  = "private"
  
  private_visibility_config_networks = [module.main_vpc.vpc_self_link]
  
  labels = {
    environment = local.environment
  }
}

# Create DNS Record
module "api_dns_record" {
  source = "../../modules/gcp-dns-record"
  
  project_id   = data.terraform_remote_state.project_setup.outputs.host_project_id
  zone_id      = module.private_dns_zone.zone_id
  record_name  = "api.${local.environment}.internal."
  record_type  = "A"
  ttl          = 300
  rrdatas      = ["10.30.1.10"]
}