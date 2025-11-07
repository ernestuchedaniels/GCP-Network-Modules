# Contributing Guide

## 🚀 Quick Start

### Prerequisites

- Terraform 1.6.6 (use tfenv)
- Access to TFE organization "Visa-replica"
- GCP project "visa-gcp-network" access

### Development Setup

```bash
# Install terraform version
tfenv install 1.6.6
tfenv use 1.6.6

# Set TFE token
export TF_API_TOKEN="your-token"

# Clone and navigate
git clone https://github.com/ernestuchedaniels/GCP-Network-Modules.git
cd GCP-Network-Modules
```

## 📋 Development Process

### 1. Making Changes

**For Infrastructure Changes:**
```bash
# Create feature branch
git checkout -b feature/description

# Navigate to target stage
cd dev-root/02-networking-core

# Edit terraform.tfvars only
vim terraform.tfvars

# Test locally
terraform init
terraform plan

# Commit and push
git add .
git commit -m "feat: add new subnet configuration"
git push origin feature/description
```

**For Module Development:**
```bash
# Work in modules directory
cd modules/new-module

# Create module structure
mkdir -p modules/gcp-new-service
cd modules/gcp-new-service

# Create module files
touch main.tf variables.tf outputs.tf README.md
```

### 2. Pull Request Process

1. **Create PR** with descriptive title
2. **Wait for validation** - GitHub Actions runs automatically
3. **Review speculative plans** - Check TFE links in PR comments
4. **Address feedback** from code review
5. **Merge** after approval - triggers apply runs

### 3. Code Standards

**Terraform Code:**
- Use `for_each` loops for all resources
- Configuration in tfvars, logic in .tf files
- Consistent variable naming: `snake_case`
- Required providers with version constraints

**File Structure:**
```
stage-folder/
├── main.tf           # Resource definitions
├── variables.tf      # Variable declarations
├── outputs.tf        # Output definitions
├── terraform.tfvars  # Configuration values
└── backend.tf        # Remote backend config
```

**Variable Patterns:**
```hcl
# variables.tf - Structure only
variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    cidr_range = string
    region     = string
  }))
}

# terraform.tfvars - Actual data
subnets = {
  "web-subnet" = {
    cidr_range = "10.0.1.0/24"
    region     = "us-central1"
  }
}
```

## 🔄 GitOps Workflow

### Automated Processes

**On Pull Request:**
- Code validation (fmt, validate)
- Speculative plans in TFE
- Automated PR comments with change details and plan links

**Example PR Comment:**
```
🔍 Speculative Plan Triggered for `dev-02-networking-core`

**Changes in this PR:**
- feat: add new subnet for web tier
- fix: update firewall rules for HTTPS
- docs: update subnet documentation

📋 **View Results:**
- [Terraform Cloud Workspace](https://app.terraform.io/app/Visa-replica/workspaces/dev-02-networking-core)
- [Plan Details](https://app.terraform.io/app/Visa-replica/workspaces/dev-02-networking-core/runs)

⏱️ Plan triggered at: 2025-01-XX...
```

**On Merge to Main:**
- Apply runs in TFE
- Infrastructure deployment
- Status updates

### Manual Overrides

**Emergency Changes:**
1. Access TFE workspace directly
2. Queue manual run with message
3. Document in PR afterward

## 🧪 Testing Strategy

### Comprehensive Test Suite

We have a complete testing framework with multiple test types:

**Test Files:**
- `tests/test_gcp_modules.py` - Python test suite for all 14+ modules
- `tests/test_monitoring_modules.py` - Monitoring-specific tests
- `tests/test_integration.tf` - Full integration testing
- `tests/run_tests.sh` - Automated test runner
- `tests/requirements.txt` - Python dependencies

### Running Tests

**Complete Test Suite:**
```bash
cd tests
bash run_tests.sh
```

**Individual Test Categories:**
```bash
# Python tests (requires pytest)
pip install -r tests/requirements.txt
pytest tests/test_gcp_modules.py -v

# Terraform validation
terraform fmt -check -recursive
terraform validate

# Integration tests
cd tests
terraform plan -var="project_id=your-project-id"
```

### Test Types

1. **Module Structure Tests** - Validates required files exist
2. **Terraform Syntax Tests** - Format and syntax validation
3. **Terraform Validation Tests** - Configuration validation
4. **Python Test Suite** - Module-specific logic testing
5. **Integration Tests** - End-to-end module interaction

### Local Testing

```bash
# Quick validation
terraform fmt -check -recursive
terraform init -backend=false
terraform validate

# Full test suite
cd tests && bash run_tests.sh

# Plan review
terraform plan
```

### Environment Promotion

1. **Dev First**: Test all changes in dev-root/
2. **Test Validation**: Run full test suite
3. **Integration Testing**: Verify module interactions
4. **Prod Deployment**: Apply same changes to prod-root/

### Test Results

**Current Status: ✅ ALL TESTS PASSING**
- Check `tests/TEST_RESULTS.md` for detailed results
- View `tests/README_VERIFICATION_REPORT.md` for documentation validation

## 📦 Module Development

### Creating New Modules

```bash
# Module structure
modules/gcp-service-name/
├── main.tf           # Primary resources
├── variables.tf      # Input variables
├── outputs.tf        # Return values
├── versions.tf       # Provider requirements
└── README.md         # Usage documentation
```

### Module Standards

- **Single Responsibility**: One service per module
- **Configurable**: Use variables for all customization
- **Documented**: Clear README with examples
- **Versioned**: Use semantic versioning

### Example Module Usage

```hcl
# In stage main.tf
module "cloud_nat" {
  source = "../../modules/gcp-cloud-nat"
  
  for_each = var.nat_gateways
  
  name       = each.key
  router     = each.value.router
  region     = each.value.region
  static_ips = each.value.static_ips
}
```

## 🔧 Troubleshooting

### Common Issues

**Terraform State Conflicts:**
```bash
# Check TFE workspace for locks
# Wait for current run to complete
# Retry operation
```

**GitHub Actions Failures:**
- Check TF_API_TOKEN secret
- Verify terraform version consistency
- Review workflow logs

**TFE Plan Failures:**
- Verify GCP credentials in variable sets
- Check resource dependencies
- Validate tfvars syntax

### Getting Help

1. **Check Documentation**: README.md and module docs
2. **Review TFE Logs**: Detailed error messages in workspace runs
3. **GitHub Issues**: Create issue with error details
4. **Team Contact**: @ernestuchedaniels

## 📊 Code Review Guidelines

### What to Review

**Infrastructure Changes:**
- Resource configuration correctness
- Security implications
- Cost impact
- Dependency management

**Code Quality:**
- Terraform best practices
- Variable naming consistency
- Documentation updates
- Test coverage

### Review Checklist

- [ ] Changes tested in dev environment
- [ ] Full test suite passes (`bash tests/run_tests.sh`)
- [ ] Documentation updated
- [ ] Security considerations addressed
- [ ] Cost impact assessed
- [ ] Dependencies verified
- [ ] Integration tests validate module interactions
- [ ] Rollback plan considered

## 🚨 Emergency Procedures

### Incident Response

1. **Assess Impact**: Identify affected resources
2. **Immediate Action**: Stop ongoing deployments if needed
3. **Rollback**: Revert to last known good state
4. **Communication**: Update team on status
5. **Post-Mortem**: Document lessons learned

### Rollback Process

```bash
# Option 1: Git revert
git revert <commit-hash>
git push origin main

# Option 2: TFE manual run
# Access workspace in TFE
# Queue run with previous configuration
# Monitor apply progress
```

## 📈 Performance Guidelines

### Resource Optimization

- Use appropriate machine types
- Implement proper subnet sizing
- Configure efficient routing
- Monitor resource utilization

### Cost Management

- Regular cost reviews
- Resource tagging strategy
- Automated cleanup policies
- Budget alerts and controls

---

## 📝 Documentation Updates

When making changes, update:

- [ ] README.md (if architecture changes)
- [ ] Module documentation
- [ ] CONTRIBUTING.md (if process changes)
- [ ] Inline code comments
- [ ] Change log entries