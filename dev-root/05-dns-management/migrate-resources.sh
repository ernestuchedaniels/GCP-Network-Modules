#!/bin/bash
# Migration script for dev-05-dns-management workspace

echo "🔄 Migrating resources for dev-05-dns-management..."

# Import DNS Zones
terraform import 'module.dns_zones["test_zone_1"].google_dns_managed_zone.zone' projects/visa-gcp-network/managedZones/test-zone-1
terraform import 'module.dns_zones["test_zone_2"].google_dns_managed_zone.zone' projects/visa-gcp-network/managedZones/test-zone-2

echo "✅ dev-05-dns-management migration complete"