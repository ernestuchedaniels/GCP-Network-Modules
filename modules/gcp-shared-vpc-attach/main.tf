resource "google_project_iam_member" "shared_vpc_attachment" {
  project = var.host_project_id
  role    = var.role
  member  = "serviceAccount:${var.service_project_number}@cloudservices.gserviceaccount.com"
}