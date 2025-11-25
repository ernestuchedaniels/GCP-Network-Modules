#!/bin/bash
# Migration script for dev-06-dns-records workspace

echo "🔄 Migrating resources for dev-06-dns-records..."

# Import DNS Records
terraform import 'module.dns_records["test_api_record"].google_dns_record_set.record' projects/visa-gcp-network/managedZones/test-zone-1/rrsets/api.test1.internal./A
terraform import 'module.dns_records["test_web_record"].google_dns_record_set.record' projects/visa-gcp-network/managedZones/test-zone-1/rrsets/web.test1.internal./A
terraform import 'module.dns_records["test_db_record"].google_dns_record_set.record' projects/visa-gcp-network/managedZones/test-zone-2/rrsets/db.test2.internal./A
terraform import 'module.dns_records["test_app_cname"].google_dns_record_set.record' projects/visa-gcp-network/managedZones/test-zone-2/rrsets/app.test2.internal./CNAME

echo "✅ dev-06-dns-records migration complete"