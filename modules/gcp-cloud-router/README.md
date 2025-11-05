# GCP Cloud Router Module

Creates a Cloud Router for dynamic routing in a VPC network.

## Usage

```hcl
module "cloud_router" {
  source = "./modules/gcp-cloud-router"

  project_id   = "my-project-id"
  network_link = module.vpc.vpc_self_link
  region       = "us-central1"
  router_name  = "my-router"
  bgp_asn      = 64512
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| network_link | The self-link of the VPC network | `string` | - | yes |
| region | The region where the router will be created | `string` | - | yes |
| router_name | Name of the cloud router | `string` | - | yes |
| description | Description of the cloud router | `string` | `""` | no |
| bgp_asn | BGP ASN for the router | `number` | `64512` | no |

## Outputs

| Name | Description |
|------|-------------|
| router_name | The name of the cloud router |
| router_self_link | The self-link of the cloud router |
| router_id | The ID of the cloud router |