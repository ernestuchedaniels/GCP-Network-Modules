# GCP Firewall Rule Module

Creates a firewall rule for a VPC network.

## Usage

```hcl
module "firewall_allow_ssh" {
  source = "./modules/gcp-firewall-rule"

  project_id    = "my-project-id"
  network_link  = module.vpc.vpc_self_link
  rule_name     = "allow-ssh"
  source_ranges = ["0.0.0.0/0"]
  
  action   = "allow"
  protocol = "tcp"
  ports    = ["22"]
  
  target_tags = ["ssh-enabled"]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| project_id | The GCP project ID | `string` | - | yes |
| network_link | The self-link of the VPC network | `string` | - | yes |
| rule_name | Name of the firewall rule | `string` | - | yes |
| source_ranges | List of source IP ranges | `list(string)` | - | yes |
| direction | Direction of the firewall rule (INGRESS or EGRESS) | `string` | `"INGRESS"` | no |
| priority | Priority of the firewall rule | `number` | `1000` | no |
| action | Action to take (allow or deny) | `string` | `"allow"` | no |
| protocol | Protocol for the rule (tcp, udp, icmp, etc.) | `string` | `"tcp"` | no |
| ports | List of ports to allow/deny | `list(string)` | `[]` | no |
| target_tags | List of target tags | `list(string)` | `[]` | no |
| source_tags | List of source tags | `list(string)` | `[]` | no |
| description | Description of the firewall rule | `string` | `""` | no |

## Outputs

None (per requirements)