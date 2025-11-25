#!/bin/bash
# Migration script for dev-02-networking-core workspace

echo "🔄 Migrating resources for dev-02-networking-core..."

# Import Test VPCs
terraform import 'module.vpcs["test_vpc_1"].google_compute_network.vpc' projects/visa-gcp-network/global/networks/test-vpc-1
terraform import 'module.vpcs["test_vpc_2"].google_compute_network.vpc' projects/visa-gcp-network/global/networks/test-vpc-2

# Import Test Subnets
terraform import 'module.subnets["test_subnet_1"].google_compute_subnetwork.subnet' projects/visa-gcp-network/regions/us-central1/subnetworks/test-subnet-1
terraform import 'module.subnets["test_subnet_2"].google_compute_subnetwork.subnet' projects/visa-gcp-network/regions/us-central1/subnetworks/test-subnet-2

echo "✅ dev-02-networking-core migration complete"