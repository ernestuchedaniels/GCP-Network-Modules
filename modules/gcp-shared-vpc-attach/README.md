# GCP Shared VPC Attach Module

Grants IAM permissions for a service project to use a Shared VPC host project.

## Usage

```hcl
module "shared_vpc_attach" {
  source = "./modules/gcp-shared-vpc-attach"

  project_id             = "my-project-id"
  host_project_id        = "shared-vpc-host"
  service_project_number = "123456789012"
  role                   = "roles/compute.networkUser"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| host_project_id | The host project ID for shared VPC | `string` | - | yes |
| service_project_number | The service project number to attach to shared VPC | `string` | - | yes |
| role | IAM role to assign | `string` | `"roles/compute.networkUser"` | no |

## Outputs

None (per requirements)