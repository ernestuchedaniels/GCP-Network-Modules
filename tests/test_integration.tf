# Integration test for GCP Network Modules
# Tests module interactions and dependencies

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.45"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

variable "project_id" {
  description = "GCP Project ID for testing"
  type        = string
  default     = "test-project-123456"
}

variable "region" {
  description = "GCP region for testing"
  type        = string
  default     = "us-central1"
}

# Test VPC module
module "test_vpc" {
  source = "../modules/gcp-vpc"
  
  project_id              = var.project_id
  network_name            = "test-vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  description             = "Test VPC for module validation"
}

# Test Subnet module
module "test_subnet" {
  source = "../modules/gcp-subnet"
  
  project_id                = var.project_id
  subnet_name               = "test-subnet"
  cidr_block                = "10.0.1.0/24"
  region                    = var.region
  vpc_link                  = module.test_vpc.vpc_self_link
  private_ip_google_access  = true
  description               = "Test subnet"
  
  secondary_ranges = [
    {
      range_name    = "pods"
      ip_cidr_range = "10.1.0.0/16"
    },
    {
      range_name    = "services"
      ip_cidr_range = "10.2.0.0/16"
    }
  ]
}

# Test Firewall rule module
module "test_firewall_allow" {
  source = "../modules/gcp-firewall-rule"
  
  project_id     = var.project_id
  rule_name      = "test-allow-http"
  network_link   = module.test_vpc.vpc_self_link
  direction      = "INGRESS"
  priority       = 1000
  action         = "allow"
  protocol       = "tcp"
  ports          = ["80", "443"]
  source_ranges  = ["0.0.0.0/0"]
  target_tags    = ["web-server"]
  description    = "Allow HTTP/HTTPS traffic"
}

# Test DNS zone module
module "test_dns_zone" {
  source = "../modules/gcp-dns-zone"
  
  project_id  = var.project_id
  zone_name   = "test-zone"
  dns_suffix  = "example.com."
  description = "Test DNS zone"
  visibility  = "public"
  
  labels = {
    environment = "test"
    purpose     = "module-testing"
  }
}

# Test DNS record module
module "test_dns_record" {
  source = "../modules/gcp-dns-record"
  
  project_id   = var.project_id
  zone_id      = module.test_dns_zone.zone_id
  record_name  = "www.example.com."
  record_type  = "A"
  ttl          = 300
  rrdatas      = ["1.2.3.4"]
}

# Test Cloud Router module
module "test_cloud_router" {
  source = "../modules/gcp-cloud-router"
  
  project_id   = var.project_id
  router_name  = "test-router"
  network_link = module.test_vpc.vpc_self_link
  region       = var.region
  description  = "Test cloud router"
}

# Test VPC Peering module
module "test_vpc_peering" {
  source = "../modules/gcp-vpc-peering"
  
  project_id           = var.project_id
  peering_name         = "test-peering"
  local_vpc_link       = module.test_vpc.vpc_self_link
  peer_vpc_link        = "projects/${var.project_id}/global/networks/peer-vpc"
  import_custom_routes = true
  export_custom_routes = true
}

# Test Monitoring Dashboard module
module "test_monitoring_dashboard" {
  source = "../modules/gcp-monitoring-dashboard"
  
  project_id  = var.project_id
  environment = "test"
}

# Test Monitoring Alert module
module "test_monitoring_alert" {
  source = "../modules/gcp-monitoring-alert"
  
  project_id           = var.project_id
  router_name          = module.test_cloud_router.router_name
  region               = var.region
  notification_channel = "projects/${var.project_id}/notificationChannels/test-channel"
}

# Test Billing Export module
module "test_billing_export" {
  source = "../modules/gcp-billing-export"
  
  billing_account_id     = "BILLING_ACCOUNT_ID"
  host_project_id        = var.project_id
  dataset_name           = "test_network_billing"
  network_team_label_key = "team"
}

# Test PSC Endpoint module
module "test_psc_endpoint" {
  source = "../modules/gcp-psc-endpoint"
  
  project_id              = var.project_id
  endpoint_name           = "test-psc-endpoint"
  subnet_link             = module.test_subnet.subnet_self_link
  service_attachment_uri  = "projects/test-project/regions/us-central1/serviceAttachments/test-attachment"
  region                  = var.region
  description             = "Test PSC endpoint"
}

# Test NCC Hub module
module "test_ncc_hub" {
  source = "../modules/gcp-ncc-hub"
  
  project_id  = var.project_id
  hub_name    = "test-ncc-hub"
  description = "Test NCC hub"
  
  labels = {
    environment = "test"
  }
}

# Test NCC Spoke module
module "test_ncc_spoke" {
  source = "../modules/gcp-ncc-spoke"
  
  project_id    = var.project_id
  spoke_name    = "test-ncc-spoke"
  hub_self_link = module.test_ncc_hub.hub_self_link
  vpc_self_link = module.test_vpc.vpc_self_link
  location      = "global"
  description   = "Test NCC spoke"
}

# Test Interconnect VLAN module
module "test_interconnect_vlan" {
  source = "../modules/gcp-interconnect-vlan"
  
  project_id        = var.project_id
  router_name       = module.test_cloud_router.router_name
  region            = var.region
  interconnect_name = "test-interconnect"
  type              = "PARTNER"
  bandwidth         = "BPS_1G"
  description       = "Test interconnect attachment"
}

# Test Host Project module (commented out - requires billing account)
# module "test_host_project" {
#   source = "../modules/gcp-host-project"
#   
#   project_id       = "test-host-project-123"
#   project_name     = "Test Host Project"
#   billing_account  = "BILLING_ACCOUNT_ID"
#   org_id           = "ORG_ID"
# }

# Test Service Project module (commented out - requires billing account)
# module "test_service_project" {
#   source = "../modules/gcp-service-project"
#   
#   project_id       = "test-service-project-123"
#   project_name     = "Test Service Project"
#   billing_account  = "BILLING_ACCOUNT_ID"
#   host_project_id  = "test-host-project-123"
# }

# Test Shared VPC Attach module (commented out - requires service project)
# module "test_shared_vpc_attach" {
#   source = "../modules/gcp-shared-vpc-attach"
#   
#   project_id             = var.project_id
#   host_project_id        = "test-host-project-123"
#   service_project_number = "123456789"
# }

# Outputs for validation
output "vpc_id" {
  value = module.test_vpc.vpc_id
}

output "subnet_id" {
  value = module.test_subnet.subnet_id
}

# Firewall module has no outputs

output "dns_zone_id" {
  value = module.test_dns_zone.zone_id
}

output "dashboard_id" {
  value = module.test_monitoring_dashboard.dashboard_id
}

output "alert_policy_id" {
  value = module.test_monitoring_alert.alert_policy_id
}

output "billing_dataset_id" {
  value = module.test_billing_export.dataset_id
}