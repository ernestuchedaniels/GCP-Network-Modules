# GCP NCC Hub Module

Creates a Network Connectivity Center (NCC) hub for connecting VPC networks.

## Usage

```hcl
module "ncc_hub" {
  source = "./modules/gcp-ncc-hub"

  project_id  = "my-project-id"
  hub_name    = "my-ncc-hub"
  description = "Central hub for network connectivity"
  
  labels = {
    environment = "production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| hub_name | Name of the NCC hub | `string` | - | yes |
| description | Description of the NCC hub | `string` | `""` | no |
| labels | Labels to apply to the hub | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| hub_self_link | The self-link of the NCC hub |
| hub_name | The name of the NCC hub |
| hub_id | The ID of the NCC hub |