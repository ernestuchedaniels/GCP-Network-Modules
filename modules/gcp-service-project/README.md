# GCP Service Project Module

Creates a GCP project configured as a Shared VPC service project attached to a host project.

## Features

- Creates a new GCP project
- Attaches to a Shared VPC host project
- Enables required APIs (Compute, DNS, Container)
- Supports organization or folder placement
- Configurable labels and network settings

## Usage

### Basic Example

```hcl
module "service_project" {
  source = "./modules/gcp-service-project"

  project_id      = "my-service-project"
  project_name    = "Application Service"
  billing_account = "ABCDEF-123456-ABCDEF"
  host_project_id = "my-host-project"
  org_id          = "123456789012"

  labels = {
    environment = "production"
    application = "web-app"
  }
}
```

### Complete Example with Host Project

```hcl
module "host_project" {
  source = "./modules/gcp-host-project"

  project_id      = "shared-vpc-host"
  project_name    = "Shared VPC Host"
  billing_account = "ABCDEF-123456-ABCDEF"
  folder_id       = "folders/123456789012"
}

module "service_project" {
  source = "./modules/gcp-service-project"

  project_id      = "app-service-project"
  project_name    = "Application Service"
  billing_account = "ABCDEF-123456-ABCDEF"
  host_project_id = module.host_project.project_id
  folder_id       = "folders/123456789012"

  labels = {
    environment = "production"
    team        = "application"
  }

  depends_on = [module.host_project]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID (6-30 chars, lowercase, alphanumeric with hyphens) | `string` | - | yes |
| project_name | The display name of the project | `string` | - | yes |
| billing_account | The billing account ID | `string` | - | yes |
| host_project_id | The host project ID for shared VPC | `string` | - | yes |
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

- `compute.googleapis.com` - Required for VMs, Load Balancers
- `dns.googleapis.com` - Required for DNS records
- `container.googleapis.com` - Required for GKE

## Notes

- The host project must exist and be configured as a Shared VPC host
- Either `org_id` or `folder_id` must be provided, not both
- Project ID must be globally unique across all GCP projects
- Service project will automatically attach to the specified host project