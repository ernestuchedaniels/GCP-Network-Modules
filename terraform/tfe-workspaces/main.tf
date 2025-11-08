terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.49"
    }
  }
}

provider "tfe" {
  token = var.tfe_token
}

locals {
  stages = [
    "01-project-setup",
    "02-networking-core",
    "03-networking-dmz",
    "04-network-peering",
    "05-dns-management",
    "06-firewall-rules",
    "07-hybrid-connectivity",
    "08-service-projects",
    "09-private-access",
    "10-monitoring",
    "11-cost-management"
  ]
  
  environments = ["dev", "prod"]
  
  workspaces = {
    for env_stage_pair in setproduct(local.environments, local.stages) :
    "${env_stage_pair[0]}-${env_stage_pair[1]}" => {
      environment = env_stage_pair[0]
      stage      = env_stage_pair[1]
    }
  }
}

# Create all workspaces
resource "tfe_workspace" "network_workspaces" {
  for_each = local.workspaces
  
  name              = each.key
  organization      = var.tfe_organization
  
  working_directory = "${each.value.environment}-root/${each.value.stage}"
  terraform_version = "1.13.5"
  execution_mode    = "remote"
  auto_apply        = true
  
  vcs_repo {
    identifier     = var.github_repo
    branch         = "main"
    oauth_token_id = var.oauth_token_id
  }
  
  tags = {
    environment = each.value.environment
    stage      = each.value.stage
    type       = "network-infrastructure"
  }
  
  description = "Workspace for ${each.value.environment} ${each.value.stage}"
}

# Create variable sets for environments
resource "tfe_variable_set" "dev_variables" {
  name         = "dev-environment-variables"
  description  = "Common variables for dev environment"
  organization = var.tfe_organization
}

resource "tfe_variable_set" "prod_variables" {
  name         = "prod-environment-variables"
  description  = "Common variables for prod environment"
  organization = var.tfe_organization
}

# Apply variable sets to workspaces
resource "tfe_workspace_variable_set" "dev_workspace_vars" {
  for_each = {
    for k, v in local.workspaces : k => v
    if v.environment == "dev"
  }
  
  workspace_id    = tfe_workspace.network_workspaces[each.key].id
  variable_set_id = tfe_variable_set.dev_variables.id
}

resource "tfe_workspace_variable_set" "prod_workspace_vars" {
  for_each = {
    for k, v in local.workspaces : k => v
    if v.environment == "prod"
  }
  
  workspace_id    = tfe_workspace.network_workspaces[each.key].id
  variable_set_id = tfe_variable_set.prod_variables.id
}

# Variables for dev environment
resource "tfe_variable" "dev_gcp_credentials" {
  key             = "GOOGLE_CREDENTIALS"
  value           = var.gcp_credentials
  category        = "env"
  sensitive       = true
  variable_set_id = tfe_variable_set.dev_variables.id
}

resource "tfe_variable" "dev_billing_account" {
  count           = var.billing_account_id != null ? 1 : 0
  key             = "TF_VAR_billing_account_id"
  value           = var.billing_account_id
  category        = "env"
  variable_set_id = tfe_variable_set.dev_variables.id
}

# Variables for prod environment
resource "tfe_variable" "prod_gcp_credentials" {
  key             = "GOOGLE_CREDENTIALS"
  value           = var.gcp_credentials
  category        = "env"
  sensitive       = true
  variable_set_id = tfe_variable_set.prod_variables.id
}

resource "tfe_variable" "prod_billing_account" {
  count           = var.billing_account_id != null ? 1 : 0
  key             = "TF_VAR_billing_account_id"
  value           = var.billing_account_id
  category        = "env"
  variable_set_id = tfe_variable_set.prod_variables.id
}

# Configure remote state sharing based on stage dependencies

# Stage 01 consumers: All other stages depend on project-setup
resource "tfe_workspace_remote_state_consumers" "project_setup_consumers" {
  for_each = {
    for k, v in local.workspaces : k => v
    if v.stage != "01-project-setup"
  }
  
  workspace_id = tfe_workspace.network_workspaces["${each.value.environment}-01-project-setup"].id
  consumer_ids = [tfe_workspace.network_workspaces[each.key].id]
}

# Stage 02 consumers: Stages 04, 05, 06, 08 depend on networking-core
resource "tfe_workspace_remote_state_consumers" "networking_core_consumers" {
  for_each = {
    for k, v in local.workspaces : k => v
    if contains(["04-network-peering", "05-dns-management", "06-firewall-rules", "08-service-projects"], v.stage)
  }
  
  workspace_id = tfe_workspace.network_workspaces["${each.value.environment}-02-networking-core"].id
  consumer_ids = [tfe_workspace.network_workspaces[each.key].id]
}

# Stage 03 consumers: Stages 04, 06 depend on networking-dmz
resource "tfe_workspace_remote_state_consumers" "networking_dmz_consumers" {
  for_each = {
    for k, v in local.workspaces : k => v
    if contains(["04-network-peering", "06-firewall-rules"], v.stage)
  }
  
  workspace_id = tfe_workspace.network_workspaces["${each.value.environment}-03-networking-dmz"].id
  consumer_ids = [tfe_workspace.network_workspaces[each.key].id]
}

# Stage 04 consumers: Stage 07 depends on network-peering
resource "tfe_workspace_remote_state_consumers" "network_peering_consumers" {
  for_each = {
    for k, v in local.workspaces : k => v
    if v.stage == "07-hybrid-connectivity"
  }
  
  workspace_id = tfe_workspace.network_workspaces["${each.value.environment}-04-network-peering"].id
  consumer_ids = [tfe_workspace.network_workspaces[each.key].id]
}

# Stage 08 consumers: Stage 09 depends on service-projects
resource "tfe_workspace_remote_state_consumers" "service_projects_consumers" {
  for_each = {
    for k, v in local.workspaces : k => v
    if v.stage == "09-private-access"
  }
  
  workspace_id = tfe_workspace.network_workspaces["${each.value.environment}-08-service-projects"].id
  consumer_ids = [tfe_workspace.network_workspaces[each.key].id]
}

# Stage 02 additional consumers: Stage 09 also depends on networking-core for subnets
resource "tfe_workspace_remote_state_consumers" "networking_core_additional_consumers" {
  for_each = {
    for k, v in local.workspaces : k => v
    if v.stage == "09-private-access"
  }
  
  workspace_id = tfe_workspace.network_workspaces["${each.value.environment}-02-networking-core"].id
  consumer_ids = [tfe_workspace.network_workspaces[each.key].id]
}

# Stages 10 & 11 consumers: Monitoring and cost management depend on all previous stages
resource "tfe_workspace_remote_state_consumers" "all_stages_consumers" {
  for_each = {
    for k, v in local.workspaces : k => v
    if contains(["10-monitoring", "11-cost-management"], v.stage)
  }
  
  workspace_id = tfe_workspace.network_workspaces[each.key].id
  consumer_ids = [
    for stage in ["01-project-setup", "02-networking-core", "03-networking-dmz", "04-network-peering", "05-dns-management", "06-firewall-rules", "07-hybrid-connectivity", "08-service-projects", "09-private-access"] :
    tfe_workspace.network_workspaces["${each.value.environment}-${stage}"].id
  ]
}