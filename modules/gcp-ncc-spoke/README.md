# GCP NCC Spoke Module

Creates a Network Connectivity Center (NCC) spoke to connect a VPC to an NCC hub.

## Usage

```hcl
module "ncc_spoke" {
  source = "./modules/gcp-ncc-spoke"

  project_id     = "my-project-id"
  hub_self_link  = module.ncc_hub.hub_self_link
  vpc_self_link  = module.vpc.vpc_self_link
  spoke_name     = "my-vpc-spoke"
  location       = "global"
  
  labels = {
    environment = "production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| hub_self_link | The self-link of the NCC hub | `string` | - | yes |
| vpc_self_link | The self-link of the VPC network | `string` | - | yes |
| spoke_name | Name of the NCC spoke | `string` | - | yes |
| location | Location for the spoke | `string` | `"global"` | no |
| description | Description of the NCC spoke | `string` | `""` | no |
| labels | Labels to apply to the spoke | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| spoke_self_link | The self-link of the NCC spoke |
| spoke_name | The name of the NCC spoke |
| spoke_id | The ID of the NCC spoke |