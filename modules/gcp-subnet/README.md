# GCP Subnet Module

Creates a subnet within a GCP VPC network.

## Usage

```hcl
module "subnet" {
  source = "./modules/gcp-subnet"

  project_id = "my-project-id"
  vpc_link   = module.vpc.vpc_self_link
  
  subnet_name = "my-subnet"
  cidr_block  = "10.0.1.0/24"
  region      = "us-central1"
  
  private_ip_google_access = true
  
  secondary_ranges = [
    {
      range_name    = "pods"
      ip_cidr_range = "10.1.0.0/16"
    },
    {
      range_name    = "services"
      ip_cidr_range = "10.2.0.0/16"
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| vpc_link | The self-link of the VPC network | `string` | - | yes |
| subnet_name | Name of the subnet | `string` | - | yes |
| cidr_block | CIDR block for the subnet | `string` | - | yes |
| region | The region where the subnet will be created | `string` | - | yes |
| description | Description of the subnet | `string` | `""` | no |
| private_ip_google_access | Whether to enable private Google access | `bool` | `true` | no |
| secondary_ranges | Secondary IP ranges for the subnet | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| subnet_self_link | The self-link of the subnet |
| subnet_name | The name of the subnet |
| subnet_id | The ID of the subnet |
| subnet_cidr | The CIDR block of the subnet |