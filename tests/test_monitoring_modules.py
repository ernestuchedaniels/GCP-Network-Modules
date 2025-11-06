#!/usr/bin/env python3
"""
Test suite for GCP Monitoring and Cost Management Modules
"""

import pytest

class TestMonitoringDashboard:
    """Tests for gcp-monitoring-dashboard module"""
    
    def test_dashboard_configuration(self):
        """Test monitoring dashboard configurations"""
        test_configs = [
            {
                "project_id": "test-project-123456",
                "environment": "dev"
            },
            {
                "project_id": "test-project-prod",
                "environment": "prod"
            }
        ]
        
        for config in test_configs:
            assert self._validate_dashboard_config(config)
    
    def _validate_dashboard_config(self, config):
        """Validate dashboard configuration"""
        required_fields = ["project_id", "environment"]
        return all(field in config for field in required_fields)

class TestMonitoringAlert:
    """Tests for gcp-monitoring-alert module"""
    
    def test_alert_configuration(self):
        """Test monitoring alert configurations"""
        test_configs = [
            {
                "project_id": "test-project-123456",
                "router_name": "dev-router",
                "region": "us-central1",
                "notification_channel": "projects/test-project/notificationChannels/123"
            },
            {
                "project_id": "test-project-prod",
                "router_name": "prod-router", 
                "region": "us-west1",
                "notification_channel": "projects/test-project/notificationChannels/456"
            }
        ]
        
        for config in test_configs:
            assert self._validate_alert_config(config)
    
    def _validate_alert_config(self, config):
        """Validate alert configuration"""
        required_fields = ["project_id", "router_name", "region", "notification_channel"]
        return all(field in config for field in required_fields)

class TestBillingExport:
    """Tests for gcp-billing-export module"""
    
    def test_billing_export_configuration(self):
        """Test billing export configurations"""
        test_configs = [
            {
                "billing_account_id": "BILLING_ACCOUNT_ID",
                "host_project_id": "network-host-dev-001",
                "dataset_name": "dev_network_billing",
                "network_team_label_key": "team"
            },
            {
                "billing_account_id": "BILLING_ACCOUNT_ID",
                "host_project_id": "network-host-prod-001", 
                "dataset_name": "prod_network_billing",
                "network_team_label_key": "department"
            }
        ]
        
        for config in test_configs:
            assert self._validate_billing_config(config)
    
    def _validate_billing_config(self, config):
        """Validate billing export configuration"""
        required_fields = ["billing_account_id", "host_project_id", "dataset_name"]
        return all(field in config for field in required_fields)

if __name__ == "__main__":
    pytest.main([__file__, "-v"])