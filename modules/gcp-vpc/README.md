# GCP VPC Module

Creates a Google Cloud VPC network with custom configuration.

## Usage

```hcl
module "vpc" {
  source = "./modules/gcp-vpc"

  project_id   = "my-project-id"
  network_name = "my-vpc-network"
  routing_mode = "GLOBAL"
  description  = "Production VPC network"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| network_name | Name of the VPC network | `string` | - | yes |
| auto_create_subnetworks | Whether to create subnetworks automatically | `bool` | `false` | no |
| routing_mode | Network routing mode (REGIONAL or GLOBAL) | `string` | `"REGIONAL"` | no |
| description | Description of the VPC network | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_self_link | The self-link of the VPC network |
| vpc_name | The name of the VPC network |
| vpc_id | The ID of the VPC network |