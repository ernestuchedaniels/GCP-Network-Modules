#!/bin/bash
# Migration script for dev-08-hybrid-connectivity workspace

echo "🔄 Migrating resources for dev-08-hybrid-connectivity..."

# Import Cloud Router
terraform import 'module.cloud_routers["test_router"].google_compute_router.router' projects/visa-gcp-network/regions/us-central1/routers/test-router

echo "✅ dev-08-hybrid-connectivity migration complete"