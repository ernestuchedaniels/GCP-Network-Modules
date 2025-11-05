resource "google_dns_record_set" "record" {
  project      = var.project_id
  managed_zone = var.zone_id
  name         = var.record_name
  type         = var.record_type
  ttl          = var.ttl
  rrdatas      = var.rrdatas
}