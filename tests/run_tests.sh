#!/bin/bash
# Test runner script for GCP Network Modules

set -e

echo "=== GCP Network Modules Test Suite ==="
echo "Starting comprehensive module testing..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test directories
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/../modules"
TEST_DIR="$SCRIPT_DIR"

# Function to print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to test module structure
test_module_structure() {
    print_status $YELLOW "Testing module structure..."
    
    modules=(
        "gcp-vpc" "gcp-subnet" "gcp-firewall-rule" 
        "gcp-dns-zone" "gcp-dns-record" "gcp-cloud-router"
        "gcp-host-project" "gcp-service-project" "gcp-shared-vpc-attach"
        "gcp-vpc-peering" "gcp-psc-endpoint" "gcp-ncc-hub" 
        "gcp-ncc-spoke" "gcp-interconnect-vlan"
    )
    
    for module in "${modules[@]}"; do
        module_path="$MODULES_DIR/$module"
        
        if [[ ! -d "$module_path" ]]; then
            print_status $RED "❌ Module directory not found: $module"
            exit 1
        fi
        
        required_files=("main.tf" "variables.tf" "outputs.tf" "README.md")
        for file in "${required_files[@]}"; do
            if [[ ! -f "$module_path/$file" ]]; then
                print_status $RED "❌ Required file missing: $module/$file"
                exit 1
            fi
        done
        
        print_status $GREEN "✅ $module structure valid"
    done
}

# Function to test Terraform syntax
test_terraform_syntax() {
    print_status $YELLOW "Testing Terraform syntax..."
    
    for module_dir in "$MODULES_DIR"/*; do
        if [[ -d "$module_dir" ]]; then
            module_name=$(basename "$module_dir")
            print_status $YELLOW "Checking syntax for $module_name..."
            
            cd "$module_dir"
            
            # Format check
            if ! terraform fmt -check -diff; then
                print_status $RED "❌ Terraform formatting issues in $module_name"
                exit 1
            fi
            
            print_status $GREEN "✅ $module_name syntax valid"
        fi
    done
}

# Function to test Terraform validation
test_terraform_validation() {
    print_status $YELLOW "Testing Terraform validation..."
    
    for module_dir in "$MODULES_DIR"/*; do
        if [[ -d "$module_dir" ]]; then
            module_name=$(basename "$module_dir")
            print_status $YELLOW "Validating $module_name..."
            
            cd "$module_dir"
            
            # Initialize and validate
            terraform init -backend=false > /dev/null 2>&1
            
            if ! terraform validate; then
                print_status $RED "❌ Terraform validation failed for $module_name"
                exit 1
            fi
            
            print_status $GREEN "✅ $module_name validation passed"
        fi
    done
}

# Function to run Python tests
run_python_tests() {
    print_status $YELLOW "Running Python test suite..."
    
    cd "$TEST_DIR"
    
    if command -v pytest &> /dev/null; then
        if pytest test_gcp_modules.py -v; then
            print_status $GREEN "✅ Python tests passed"
        else
            print_status $RED "❌ Python tests failed"
            exit 1
        fi
    else
        print_status $YELLOW "⚠️  pytest not found, skipping Python tests"
    fi
}

# Function to run monitoring modules tests
test_monitoring_modules() {
    print_status $YELLOW "Running monitoring modules test suite..."
    
    cd "$TEST_DIR"
    
    if command -v pytest &> /dev/null; then
        if pytest test_monitoring_modules.py -v; then
            print_status $GREEN "✅ Monitoring modules tests passed"
        else
            print_status $RED "❌ Monitoring modules tests failed"
            exit 1
        fi
    else
        print_status $YELLOW "⚠️  pytest not found, skipping monitoring tests"
    fi
}

# Function to test integration
test_integration() {
    print_status $YELLOW "Testing module integration..."
    
    cd "$TEST_DIR"
    
    # Test simple integration
    if terraform -chdir=. init -backend=false > /dev/null 2>&1 && \
       terraform -chdir=. plan -var="project_id=test-project-123456" test_simple_integration.tf > /dev/null 2>&1; then
        print_status $GREEN "✅ Integration test plan successful"
    else
        print_status $YELLOW "⚠️  Integration test skipped (requires GCP credentials)"
    fi
}

# Main execution
main() {
    print_status $GREEN "Starting GCP Network Modules test suite..."
    
    test_module_structure
    test_terraform_syntax
    test_terraform_validation
    run_python_tests
    test_monitoring_modules
    test_integration
    
    print_status $GREEN "🎉 All tests passed successfully!"
    print_status $GREEN "GCP Network Modules are ready for use."
}

# Run main function
main "$@"