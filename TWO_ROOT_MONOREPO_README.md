# GCP Shared VPC Two-Root Monorepo Structure

## Overview

This repository implements a **Two-Root Monorepo pattern** for GCP Shared VPC infrastructure, providing complete separation between development and production environments while maintaining code reusability through shared modules.

## Directory Structure

```
GCP-Network-Modules/
├── modules/                    # Shared Terraform modules
│   ├── gcp-vpc/
│   ├── gcp-subnet/
│   ├── gcp-host-project/
│   ├── gcp-service-project/
│   └── ... (14 total modules)
├── dev-root/                   # Development environment
│   ├── 01-project-setup/
│   ├── 02-networking-core/
│   ├── 03-hybrid-connectivity/
│   ├── 04-service-projects/
│   └── 05-private-access/
└── prod-root/                  # Production environment
    ├── 01-project-setup/
    ├── 02-networking-core/
    ├── 03-hybrid-connectivity/
    ├── 04-service-projects/
    └── 05-private-access/
```

## Five-Stage Deployment Architecture

### Stage 01: Project Setup
- **Purpose**: Creates host project and enables Shared VPC
- **Resources**: Host project, Shared VPC enablement
- **Dependencies**: None (foundation stage)

### Stage 02: Networking Core
- **Purpose**: Creates VPC network and primary subnets
- **Resources**: VPC network, subnets with secondary ranges
- **Dependencies**: Stage 01 (host project)

### Stage 03: Hybrid Connectivity
- **Purpose**: Establishes hybrid cloud connectivity
- **Resources**: Cloud Router, NCC Hub, Interconnect VLAN
- **Dependencies**: Stages 01-02 (project and network)

### Stage 04: Service Projects
- **Purpose**: Creates and attaches consumer projects
- **Resources**: Service projects, Shared VPC attachments
- **Dependencies**: Stage 01 (host project)

### Stage 05: Private Access
- **Purpose**: Configures private service access
- **Resources**: PSC endpoints, VPC peering
- **Dependencies**: Stages 02, 04 (network and service projects)

## Environment Differences

| Aspect | Development | Production |
|--------|-------------|------------|
| **Environment Variable** | `local.environment = "dev"` | `local.environment = "prod"` |
| **Host Project ID** | `network-host-dev-001` | `network-host-prod-001` |
| **Service Project ID** | `app-sp-dev-001` | `app-sp-prod-001` |
| **Primary CIDR** | `10.20.0.0/20` | `10.30.0.0/20` |
| **BGP ASN** | `65000` | `65001` |
| **Interconnect Bandwidth** | `BPS_1G` | `BPS_10G` |
| **Config Files** | `dev.tfvars` | `prod.tfvars` |

## CI/CD Pipeline Deployment

### Prerequisites
1. GitHub repository with this code
2. Terraform Enterprise/Cloud workspace
3. GCP OIDC authentication configured
4. GitHub Actions workflows

### Deployment Strategy
- **GitHub Actions** orchestrate the deployment pipeline
- **Terraform Enterprise** manages state and execution
- **OIDC** provides secure authentication to GCP
- **Sequential stages** deployed automatically based on git workflow

## State Management

Each stage maintains its own Terraform state file:
- **Local Backend**: Used for simplicity in this example
- **Remote Backend**: Recommended for production (GCS, Terraform Cloud)

### Remote State Configuration Example

```hcl
terraform {
  backend "gcs" {
    bucket = "terraform-state-bucket"
    prefix = "dev/01-project-setup"
  }
}
```

## Module Dependencies

All modules use local path references:
```hcl
module "example" {
  source = "../../modules/gcp-vpc"
  # ...
}
```

## Key Features

### ✅ Environment Isolation
- Complete separation between dev and prod
- Independent state management
- Environment-specific configurations

### ✅ Sequential Deployment
- Numbered stages enforce execution order
- Clear dependency management
- Incremental rollout capability

### ✅ Code Reusability
- Shared modules across environments
- Consistent infrastructure patterns
- DRY principle implementation

### ✅ Scalability
- Easy to add new environments
- Modular architecture
- Stage-based expansion

## Customization

### Adding New Environments
1. Create new root directory (e.g., `staging-root/`)
2. Copy stage structure from existing environment
3. Update `local.environment` and variable values
4. Create environment-specific `.tfvars` files

### Adding New Stages
1. Create new numbered directory (e.g., `06-monitoring/`)
2. Follow existing stage patterns
3. Update remote state references as needed
4. Document dependencies

## Best Practices

1. **Always deploy stages sequentially** (01 → 02 → 03 → 04 → 05)
2. **Use environment-specific variable files**
3. **Validate plans before applying**
4. **Maintain consistent naming conventions**
5. **Document any customizations**

## Troubleshooting

### Common Issues
- **State file conflicts**: Ensure unique state paths per environment
- **Module not found**: Verify relative paths to modules directory
- **Remote state errors**: Check terraform_remote_state configurations
- **Permission errors**: Verify IAM roles and API enablement

### Recovery Procedures
- **State corruption**: Use terraform state commands for recovery
- **Failed deployments**: Review logs and apply targeted fixes
- **Dependency issues**: Verify stage execution order

This structure provides a robust, scalable foundation for managing GCP Shared VPC infrastructure across multiple environments.