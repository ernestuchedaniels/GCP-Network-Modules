# GCP Monitoring Dashboard Module

Creates a Google Cloud Monitoring dashboard for network health visualization.

## Usage

```hcl
module "network_dashboard" {
  source = "../../modules/gcp-monitoring-dashboard"
  
  project_id  = "my-project-id"
  environment = "dev"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| environment | Environment name (dev, prod, etc.) | `string` | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| dashboard_id | The ID of the monitoring dashboard |

## Dashboard Widgets

1. **VPC Flow Log Byte Volume** - Line chart showing network traffic volume
2. **Cloud Router BGP Session Status** - Gauge showing BGP session health