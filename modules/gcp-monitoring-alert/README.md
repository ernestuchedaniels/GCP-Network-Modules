# GCP Monitoring Alert Module

Creates a Google Cloud Monitoring alert policy for BGP session failures.

## Usage

```hcl
module "bgp_alert" {
  source = "../../modules/gcp-monitoring-alert"
  
  project_id           = "my-project-id"
  router_name          = "my-router"
  region               = "us-central1"
  notification_channel = "projects/my-project/notificationChannels/123456"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| router_name | Name of the cloud router to monitor | `string` | - | yes |
| region | Region of the cloud router | `string` | - | yes |
| notification_channel | Notification channel ID for alerts | `string` | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| alert_policy_id | The ID of the alert policy |

## Alert Details

- **Metric**: `cloudrouter.googleapis.com/router/bgp_session_status`
- **Condition**: BGP session status = 1 (DOWN)
- **Duration**: 5 minutes
- **Auto-close**: 30 minutes