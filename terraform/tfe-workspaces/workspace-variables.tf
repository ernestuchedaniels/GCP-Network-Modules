# Common GCP variables for dev environment
resource "tfe_variable" "dev_gcp_credentials" {
  key             = "GOOGLE_CREDENTIALS"
  value           = var.gcp_credentials
  category        = "env"
  workspace_id    = null
  variable_set_id = tfe_variable_set.dev_variables.id
  sensitive       = true
  description     = "GCP service account credentials for dev environment"
}

resource "tfe_variable" "dev_billing_account" {
  count = var.billing_account_id != null ? 1 : 0
  
  key             = "TF_VAR_billing_account_id"
  value           = var.billing_account_id
  category        = "env"
  workspace_id    = null
  variable_set_id = tfe_variable_set.dev_variables.id
  description     = "GCP billing account ID"
}

resource "tfe_variable" "dev_organization_id" {
  count = var.organization_id != null ? 1 : 0
  
  key             = "TF_VAR_organization_id"
  value           = var.organization_id
  category        = "env"
  workspace_id    = null
  variable_set_id = tfe_variable_set.dev_variables.id
  description     = "GCP organization ID"
}

# Common GCP variables for prod environment
resource "tfe_variable" "prod_gcp_credentials" {
  key             = "GOOGLE_CREDENTIALS"
  value           = var.gcp_credentials
  category        = "env"
  workspace_id    = null
  variable_set_id = tfe_variable_set.prod_variables.id
  sensitive       = true
  description     = "GCP service account credentials for prod environment"
}

resource "tfe_variable" "prod_billing_account" {
  count = var.billing_account_id != null ? 1 : 0
  
  key             = "TF_VAR_billing_account_id"
  value           = var.billing_account_id
  category        = "env"
  workspace_id    = null
  variable_set_id = tfe_variable_set.prod_variables.id
  description     = "GCP billing account ID"
}

resource "tfe_variable" "prod_organization_id" {
  count = var.organization_id != null ? 1 : 0
  
  key             = "TF_VAR_organization_id"
  value           = var.organization_id
  category        = "env"
  workspace_id    = null
  variable_set_id = tfe_variable_set.prod_variables.id
  description     = "GCP organization ID"
}