# Enable BigQuery API
resource "google_project_service" "bigquery" {
  project = var.host_project_id
  service = "bigquery.googleapis.com"
}

# Create BigQuery dataset for billing export
resource "google_bigquery_dataset" "billing_dataset" {
  project    = var.host_project_id
  dataset_id = var.dataset_name
  location   = "US"

  description = "Dataset for network team billing export and cost analysis"

  labels = {
    team        = "network"
    environment = "shared"
  }

  depends_on = [google_project_service.bigquery]
}

# Create billing budget monitor for network team resources
resource "google_billing_budget" "network_budget_monitor" {
  billing_account = var.billing_account_id
  display_name    = "Network Team Budget Monitor"

  budget_filter {
    projects = ["projects/${var.host_project_id}"]
    labels = {
      "${var.network_team_label_key}" = ["network"]
    }
  }

  amount {
    specified_amount {
      currency_code = "USD"
      units         = "1000"
    }
  }

  threshold_rules {
    threshold_percent = 0.8
    spend_basis       = "CURRENT_SPEND"
  }

  threshold_rules {
    threshold_percent = 1.0
    spend_basis       = "CURRENT_SPEND"
  }
}

# Enable BigQuery Data Transfer Service
resource "google_project_service_identity" "bq_transfer" {
  provider = google-beta
  project  = var.host_project_id
  service  = "bigquerydatatransfer.googleapis.com"
}

# Grant BigQuery Data Editor role to billing export service account
resource "google_project_iam_member" "billing_export_bq_editor" {
  project = var.host_project_id
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${data.google_billing_account.account.name}@system.gserviceaccount.com"
}

# Data source to get billing account details
data "google_billing_account" "account" {
  billing_account = var.billing_account_id
}