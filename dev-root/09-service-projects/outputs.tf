output "service_project_ids" {
  description = "Map of service project IDs"
  value = {
    for k, v in module.service_projects : k => v.project_id
  }
}

output "service_project_numbers" {
  description = "Map of service project numbers"
  value = {
    for k, v in module.service_projects : k => v.project_number
  }
}
