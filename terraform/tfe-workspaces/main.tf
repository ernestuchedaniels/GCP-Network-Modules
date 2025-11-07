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
  file_triggers_enabled = true
  
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

# host_project_id and org_id variables already exist in TFE variable sets

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

# host_project_id and org_id variables already exist in TFE variable sets