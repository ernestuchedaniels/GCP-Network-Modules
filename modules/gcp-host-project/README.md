# GCP Host Project Module

Creates a GCP project configured as a Shared VPC host project with required APIs enabled.

## Features

- Creates a new GCP project
- Enables Shared VPC host functionality
- Enables required APIs (Compute, Cloud Resource Manager, Service Networking)
- Supports organization or folder placement
- Configurable labels and network settings

## Usage

### Basic Example

```hcl
module "host_project" {
  source = "./modules/gcp-host-project"

  project_id      = "my-host-project"
  project_name    = "Shared VPC Host"
  billing_account = "ABCDEF-123456-ABCDEF"
  org_id          = "123456789012"

  labels = {
    environment = "production"
    team        = "networking"
  }
}
```

### With Folder Placement

```hcl
module "host_project" {
  source = "./modules/gcp-host-project"

  project_id      = "my-host-project"
  project_name    = "Shared VPC Host"
  billing_account = "ABCDEF-123456-ABCDEF"
  folder_id       = "folders/123456789012"

  auto_create_network = false

  labels = {
    environment = "production"
    cost_center = "networking"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID (6-30 chars, lowercase, alphanumeric with hyphens) | `string` | - | yes |
| project_name | The display name of the project | `string` | - | yes |
| billing_account | The billing account ID | `string` | - | yes |
| org_id | The organization ID | `string` | `null` | no |
| folder_id | The folder ID to create the project in | `string` | `null` | no |
| auto_create_network | Whether to automatically create the default network | `bool` | `false` | no |
| labels | Labels to apply to the project | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| project_id | The project ID |
| project_number | The project number |
| project_name | The project name |

## APIs Enabled

- `compute.googleapis.com` - Required for VPC, Subnets, Routers
- `cloudresourcemanager.googleapis.com` - Required for project management
- `servicenetworking.googleapis.com` - Required for PSC and Private Services

## Notes

- Either `org_id` or `folder_id` must be provided, not both
- Project ID must be globally unique across all GCP projects
- Billing account must be active and accessible
- The project will be configured as a Shared VPC host automatically