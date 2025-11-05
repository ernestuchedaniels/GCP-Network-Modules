# GCP Interconnect VLAN Module

Creates a VLAN attachment for Cloud Interconnect.

## Usage

```hcl
module "interconnect_vlan" {
  source = "./modules/gcp-interconnect-vlan"

  project_id         = "my-project-id"
  router_name        = module.cloud_router.router_name
  region             = "us-central1"
  interconnect_name  = "my-vlan-attachment"
  type               = "PARTNER"
  bandwidth          = "BPS_1G"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| router_name | Name of the cloud router | `string` | - | yes |
| region | The region where the interconnect will be created | `string` | - | yes |
| interconnect_name | Name of the interconnect attachment | `string` | - | yes |
| type | Type of interconnect attachment | `string` | `"PARTNER"` | no |
| edge_availability_domain | Edge availability domain | `string` | `"AVAILABILITY_DOMAIN_1"` | no |
| admin_enabled | Whether the attachment is enabled | `bool` | `true` | no |
| bandwidth | Bandwidth of the interconnect attachment | `string` | `"BPS_1G"` | no |
| description | Description of the interconnect attachment | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| vlan_self_link | The self-link of the interconnect attachment |
| vlan_name | The name of the interconnect attachment |
| vlan_id | The ID of the interconnect attachment |