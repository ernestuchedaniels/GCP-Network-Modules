# GCP DNS Record Module

Creates a DNS record in a Cloud DNS managed zone.

## Features

- Simplified user experience with default TTL (300 seconds)
- TTL is optional - no need to specify in tfvars unless you need a custom value
- Supports all DNS record types (A, AAAA, CNAME, MX, TXT, etc.)

## Usage

```hcl
module "dns_a_record" {
  source = "./modules/gcp-dns-record"

  project_id  = "my-project-id"
  zone_id     = module.dns_zone.zone_id
  record_name = "app.example.com."
  record_type = "A"
  rrdatas     = ["10.0.1.10"]
  # ttl defaults to 300 seconds - only specify if you need a different value
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| zone_id | The ID of the DNS zone | `string` | - | yes |
| record_name | Name of the DNS record | `string` | - | yes |
| record_type | Type of the DNS record (A, AAAA, CNAME, etc.) | `string` | - | yes |
| rrdatas | List of resource record data | `list(string)` | - | yes |
| ttl | TTL for the DNS record | `number` | `300` | no |

## Outputs

None (per requirements)