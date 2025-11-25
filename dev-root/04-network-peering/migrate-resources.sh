#!/bin/bash
# Migration script for dev-04-network-peering workspace

echo "🔄 Migrating resources for dev-04-network-peering..."

# Import VPC Peerings
terraform import 'module.vpc_peering["test_vpc_1_to_2"].google_compute_network_peering.peering' visa-gcp-network/test-vpc-1/test-vpc-1-to-test-vpc-2
terraform import 'module.vpc_peering["test_vpc_2_to_1"].google_compute_network_peering.peering' visa-gcp-network/test-vpc-2/test-vpc-2-to-test-vpc-1

echo "✅ dev-04-network-peering migration complete"