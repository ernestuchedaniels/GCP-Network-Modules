# GCP VPC Peering Module

Creates a VPC network peering connection between two VPC networks.

## Usage

```hcl
module "vpc_peering" {
  source = "./modules/gcp-vpc-peering"

  project_id      = "my-project-id"
  peering_name    = "vpc-a-to-vpc-b"
  local_vpc_link  = module.vpc_a.vpc_self_link
  peer_vpc_link   = module.vpc_b.vpc_self_link
  
  import_custom_routes = true
  export_custom_routes = true
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| local_vpc_link | The self-link of the local VPC network | `string` | - | yes |
| peer_vpc_link | The self-link of the peer VPC network | `string` | - | yes |
| peering_name | Name of the VPC peering connection | `string` | - | yes |
| import_custom_routes | Whether to import custom routes from peer network | `bool` | `false` | no |
| export_custom_routes | Whether to export custom routes to peer network | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| peering_name | The name of the VPC peering connection |
| peering_id | The ID of the VPC peering connection |
| peering_state | The state of the VPC peering connection |