# GCP Billing Export Module

Creates BigQuery dataset and billing budget for network team cost reporting.

## Usage

```hcl
module "billing_export" {
  source = "../../modules/gcp-billing-export"
  
  billing_account_id     = "BILLING_ACCOUNT_ID"
  host_project_id        = "my-host-project"
  dataset_name           = "network_billing"
  network_team_label_key = "team"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| billing_account_id | The billing account ID | `string` | - | yes |
| host_project_id | The host project ID where BigQuery dataset will reside | `string` | - | yes |
| dataset_name | Name of the BigQuery dataset | `string` | - | yes |
| network_team_label_key | Label key to filter network team resources | `string` | `"team"` | no |

## Outputs

| Name | Description |
|------|-------------|
| dataset_id | The ID of the BigQuery dataset |

## Resources Created

1. **BigQuery Dataset** - For storing billing export data
2. **Billing Budget** - Monitors costs for network team labeled resources
3. **IAM Bindings** - Grants necessary permissions for billing export
4. **Service Identity** - Enables BigQuery Data Transfer Service