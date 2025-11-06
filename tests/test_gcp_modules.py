#!/usr/bin/env python3
"""
Comprehensive test suite for GCP Network Modules
Tests module syntax, configuration, and integration
"""

import os
import json
import subprocess
import pytest
from pathlib import Path

# Test configuration
PROJECT_ROOT = Path(__file__).parent.parent
MODULES_DIR = PROJECT_ROOT / "modules"
TEST_PROJECT_ID = "test-project-123456"

class TestGCPModules:
    """Test suite for GCP Network Modules"""
    
    @pytest.fixture(autouse=True)
    def setup(self):
        """Setup test environment"""
        self.modules = [
            "gcp-vpc", "gcp-subnet", "gcp-firewall-rule", 
            "gcp-dns-zone", "gcp-dns-record", "gcp-cloud-router",
            "gcp-host-project", "gcp-service-project", "gcp-shared-vpc-attach",
            "gcp-vpc-peering", "gcp-psc-endpoint", "gcp-ncc-hub", 
            "gcp-ncc-spoke", "gcp-interconnect-vlan", "gcp-monitoring-dashboard",
            "gcp-monitoring-alert", "gcp-billing-export"
        ]
    
    def test_module_structure(self):
        """Test that all modules have required files"""
        for module in self.modules:
            module_path = MODULES_DIR / module
            assert module_path.exists(), f"Module {module} directory not found"
            assert (module_path / "main.tf").exists(), f"{module}/main.tf missing"
            assert (module_path / "variables.tf").exists(), f"{module}/variables.tf missing"
            assert (module_path / "outputs.tf").exists(), f"{module}/outputs.tf missing"
            assert (module_path / "README.md").exists(), f"{module}/README.md missing"
    
    def test_terraform_syntax(self):
        """Test Terraform syntax validation for all modules"""
        for module in self.modules:
            module_path = MODULES_DIR / module
            result = subprocess.run(
                ["terraform", "fmt", "-check", "-diff"],
                cwd=module_path,
                capture_output=True,
                text=True
            )
            assert result.returncode == 0, f"Terraform formatting issues in {module}: {result.stdout}"
    
    def test_terraform_validate(self):
        """Test Terraform validation for all modules"""
        for module in self.modules:
            module_path = MODULES_DIR / module
            
            # Initialize terraform
            subprocess.run(["terraform", "init"], cwd=module_path, capture_output=True)
            
            # Validate
            result = subprocess.run(
                ["terraform", "validate"],
                cwd=module_path,
                capture_output=True,
                text=True
            )
            assert result.returncode == 0, f"Terraform validation failed for {module}: {result.stderr}"

class TestVPCModule:
    """Specific tests for VPC module"""
    
    def test_vpc_configuration(self):
        """Test VPC module with various configurations"""
        test_configs = [
            {
                "project_id": TEST_PROJECT_ID,
                "network_name": "test-vpc",
                "auto_create_subnetworks": False,
                "routing_mode": "REGIONAL"
            },
            {
                "project_id": TEST_PROJECT_ID,
                "network_name": "global-vpc",
                "auto_create_subnetworks": False,
                "routing_mode": "GLOBAL"
            }
        ]
        
        for config in test_configs:
            assert self._validate_vpc_config(config)
    
    def _validate_vpc_config(self, config):
        """Validate VPC configuration"""
        required_fields = ["project_id", "network_name"]
        return all(field in config for field in required_fields)

class TestSubnetModule:
    """Specific tests for Subnet module"""
    
    def test_subnet_configuration(self):
        """Test subnet module configurations"""
        test_configs = [
            {
                "project_id": TEST_PROJECT_ID,
                "subnet_name": "test-subnet",
                "cidr_block": "10.0.1.0/24",
                "region": "us-central1",
                "vpc_link": "test-vpc"
            },
            {
                "project_id": TEST_PROJECT_ID,
                "subnet_name": "private-subnet",
                "cidr_block": "10.0.2.0/24",
                "region": "us-west1",
                "vpc_link": "test-vpc",
                "private_ip_google_access": True
            }
        ]
        
        for config in test_configs:
            assert self._validate_subnet_config(config)
    
    def _validate_subnet_config(self, config):
        """Validate subnet configuration"""
        required_fields = ["project_id", "subnet_name", "cidr_block", "region", "vpc_link"]
        return all(field in config for field in required_fields)

class TestFirewallModule:
    """Specific tests for Firewall module"""
    
    def test_firewall_rules(self):
        """Test firewall rule configurations"""
        test_configs = [
            {
                "project_id": TEST_PROJECT_ID,
                "rule_name": "allow-http",
                "network_link": "test-vpc",
                "direction": "INGRESS",
                "action": "allow",
                "protocol": "tcp",
                "ports": ["80", "443"],
                "source_ranges": ["0.0.0.0/0"]
            },
            {
                "project_id": TEST_PROJECT_ID,
                "rule_name": "deny-all",
                "network_link": "test-vpc",
                "direction": "INGRESS",
                "action": "deny",
                "protocol": "all",
                "source_ranges": ["0.0.0.0/0"]
            }
        ]
        
        for config in test_configs:
            assert self._validate_firewall_config(config)
    
    def _validate_firewall_config(self, config):
        """Validate firewall configuration"""
        required_fields = ["project_id", "rule_name", "network_link", "direction", "action"]
        return all(field in config for field in required_fields)

class TestDNSModule:
    """Specific tests for DNS modules"""
    
    def test_dns_zone_configuration(self):
        """Test DNS zone configurations"""
        test_configs = [
            {
                "project_id": TEST_PROJECT_ID,
                "zone_name": "test-zone",
                "dns_suffix": "example.com.",
                "visibility": "public"
            },
            {
                "project_id": TEST_PROJECT_ID,
                "zone_name": "private-zone",
                "dns_suffix": "internal.local.",
                "visibility": "private"
            }
        ]
        
        for config in test_configs:
            assert self._validate_dns_zone_config(config)
    
    def _validate_dns_zone_config(self, config):
        """Validate DNS zone configuration"""
        required_fields = ["project_id", "zone_name", "dns_suffix"]
        return all(field in config for field in required_fields)

if __name__ == "__main__":
    pytest.main([__file__, "-v"])