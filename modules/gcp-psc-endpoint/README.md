# GCP PSC Endpoint Module

Creates a Private Service Connect (PSC) endpoint.

## Usage

```hcl
module "psc_endpoint" {
  source = "./modules/gcp-psc-endpoint"

  project_id              = "my-project-id"
  subnet_link             = module.subnet.subnet_self_link
  endpoint_name           = "my-psc-endpoint"
  service_attachment_uri  = "projects/SERVICE_PROJECT/regions/us-central1/serviceAttachments/SERVICE_NAME"
  region                  = "us-central1"
  
  labels = {
    environment = "production"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| subnet_link | The self-link of the subnet | `string` | - | yes |
| endpoint_name | Name of the PSC endpoint | `string` | - | yes |
| service_attachment_uri | URI of the service attachment | `string` | - | yes |
| region | The region where the endpoint will be created | `string` | - | yes |
| ip_address | Internal IP address for the endpoint (optional) | `string` | `null` | no |
| labels | Labels to apply to the endpoint | `map(string)` | `{}` | no |
| description | Description of the PSC endpoint | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| psc_internal_ip | The internal IP address of the PSC endpoint |