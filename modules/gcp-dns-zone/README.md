# GCP DNS Zone Module

Creates a Cloud DNS managed zone.

## Usage

### Public DNS Zone

```hcl
module "public_dns_zone" {
  source = "./modules/gcp-dns-zone"

  project_id = "my-project-id"
  zone_name  = "my-public-zone"
  dns_suffix = "example.com."
  visibility = "public"
}
```

### Private DNS Zone

```hcl
module "private_dns_zone" {
  source = "./modules/gcp-dns-zone"

  project_id = "my-project-id"
  zone_name  = "my-private-zone"
  dns_suffix = "internal.example.com."
  visibility = "private"
  
  private_visibility_config_networks = [
    module.vpc.vpc_self_link
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| zone_name | Name of the DNS zone | `string` | - | yes |
| dns_suffix | DNS suffix for the zone | `string` | - | yes |
| description | Description of the DNS zone | `string` | `""` | no |
| visibility | Visibility of the DNS zone (public or private) | `string` | `"public"` | no |
| private_visibility_config_networks | List of VPC networks for private zone visibility | `list(string)` | `[]` | no |
| labels | Labels to apply to the DNS zone | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| zone_id | The ID of the DNS zone |
| zone_name | The name of the DNS zone |
| name_servers | The name servers for the DNS zone |