output "workspace_names" {
  description = "Names of all created workspaces"
  value       = [for ws in tfe_workspace.network_workspaces : ws.name]
}

output "workspace_ids" {
  description = "IDs of all created workspaces"
  value = {
    for k, ws in tfe_workspace.network_workspaces : k => ws.id
  }
}

output "dev_variable_set_id" {
  description = "ID of dev environment variable set"
  value       = tfe_variable_set.dev_variables.id
}

output "prod_variable_set_id" {
  description = "ID of prod environment variable set"
  value       = tfe_variable_set.prod_variables.id
}