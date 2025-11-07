# TFE Workspace Management

## Overview
This Terraform configuration creates and manages all 22 workspaces (11 dev + 11 prod) in Terraform Enterprise for the GCP Network Modules project.

## Prerequisites

### 1. TFE Team Token
Create a team token in Terraform Enterprise:
1. Go to Organization Settings → Teams
2. Create "workspace-management" team
3. Assign "Manage Workspaces" permission
4. Generate Team API Token

### 2. GCP Service Account
Create a service account with necessary permissions:
- Project Creator
- Billing Account User
- Organization Administrator (if using organization)

## Setup Instructions

### 1. Configure Variables
```bash
# Non-sensitive values are already in terraform.tfvars
# Edit terraform.tfvars with your organization/project details

# Create sensitive values file
cp sensitive.tfvars.example sensitive.tfvars
# Edit sensitive.tfvars with your tokens and credentials
```

### 2. Initialize and Apply
```bash
terraform init
terraform plan -var-file="sensitive.tfvars"
terraform apply -var-file="sensitive.tfvars"
```

### 3. Verify Workspaces
Check Terraform Enterprise UI to confirm all 22 workspaces are created:
- dev-01-project-setup through dev-11-cost-management
- prod-01-project-setup through prod-11-cost-management

## Workspace Configuration

### Working Directories
Each workspace is configured with the correct working directory:
- `dev-01-project-setup` → `dev-root/01-project-setup/`
- `prod-05-dns-management` → `prod-root/05-dns-management/`

### VCS Integration
All workspaces are connected to the GitHub repository with:
- Branch: `main`
- Auto-apply: Disabled (manual approval required)

### Variable Sets
Two variable sets are created and applied:
- `dev-environment-variables` → All dev-* workspaces
- `prod-environment-variables` → All prod-* workspaces

## Common Variables
The following variables are automatically set in all workspaces:
- `GOOGLE_CREDENTIALS` (sensitive)
- `TF_VAR_billing_account_id`
- `TF_VAR_organization_id`

## Workspace Tags
All workspaces are tagged with:
- Environment: `dev` or `prod`
- Stage: `01-project-setup`, `02-networking-core`, etc.
- Category: `network-infrastructure`

## Maintenance

### Adding New Stages
1. Add stage name to `locals.stages` in `main.tf`
2. Run `terraform apply` to create new workspaces

### Updating Variables
1. Modify variable resources in `workspace-variables.tf`
2. Run `terraform apply` to update all workspaces

### Workspace Cleanup
```bash
terraform destroy
```
**Warning:** This will delete all workspaces and their configurations.

## Troubleshooting

### Authentication Issues
- Verify TFE token has correct permissions
- Check organization name is correct

### Workspace Creation Failures
- Ensure GitHub repository exists and is accessible
- Verify working directories exist in repository

### Variable Set Issues
- Check variable syntax and sensitivity settings
- Verify GCP credentials are valid JSON