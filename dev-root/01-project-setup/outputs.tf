output "host_project_id" {
  description = "The host project ID"
  value       = var.host_project_id
}

# Shared VPC output - commented out for testing
# output "shared_vpc_host_project" {
#   description = "The shared VPC host project resource"
#   value       = google_compute_shared_vpc_host_project.shared_vpc_host.project
# }