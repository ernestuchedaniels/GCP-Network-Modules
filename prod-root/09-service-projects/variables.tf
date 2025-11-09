variable "service_projects" {
  description = "Map of service projects to create"
  type = map(object({
    project_id      = string
    project_name    = string
    billing_account = string
    org_id          = string
    labels          = map(string)
  }))
}