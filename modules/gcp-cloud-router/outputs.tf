output "router_name" {
  description = "The name of the cloud router"
  value       = google_compute_router.router.name
}

output "router_self_link" {
  description = "The self-link of the cloud router"
  value       = google_compute_router.router.self_link
}

output "router_id" {
  description = "The ID of the cloud router"
  value       = google_compute_router.router.id
}