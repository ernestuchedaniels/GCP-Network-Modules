resource "google_project" "main" {
  project_id          = var.project_id
  name                = var.project_name
  org_id              = var.org_id
  folder_id           = var.folder_id
  billing_account     = var.billing_account
  auto_create_network = var.auto_create_network
  labels              = var.labels
}

resource "google_project_service" "apis" {
  for_each = toset([
    "compute.googleapis.com",
    "dns.googleapis.com",
    "container.googleapis.com"
  ])
  project            = google_project.main.project_id
  service            = each.value
  disable_on_destroy = false
}

resource "google_compute_shared_vpc_service_project" "shared_vpc_service" {
  host_project    = var.host_project_id
  service_project = google_project.main.project_id
  depends_on      = [google_project_service.apis]
}