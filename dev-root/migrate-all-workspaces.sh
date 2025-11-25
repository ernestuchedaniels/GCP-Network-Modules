#!/bin/bash
# Master migration script - runs all workspace migrations sequentially

# Use correct terraform version
export PATH=~/bin:$PATH

echo "🚀 Starting migration of all test resources to TFE workspaces..."

# Run in dependency order
WORKSPACES=(
  "02-networking-core"   # VPCs and subnets first
  "05-dns-management"    # DNS zones second
  "04-network-peering"   # VPC peerings third (needs VPCs)
  "08-hybrid-connectivity" # Cloud router fourth (needs VPCs)
  "06-dns-records"       # DNS records last (needs DNS zones)
)

for workspace in "${WORKSPACES[@]}"; do
  echo ""
  echo "📂 Processing workspace: $workspace"
  cd "$workspace"
  
  # Initialize workspace
  terraform init
  
  # Run migration script
  chmod +x migrate-resources.sh
  ./migrate-resources.sh
  
  # Verify with plan
  echo "🔍 Verifying migration with terraform plan..."
  PATH=~/bin:$PATH terraform plan
  
  cd ..
done

echo ""
echo "✅ All workspace migrations complete!"
echo "📋 Summary:"
echo "  - 02-networking-core: VPCs and subnets imported"
echo "  - 05-dns-management: DNS zones imported"
echo "  - 04-network-peering: VPC peerings imported"
echo "  - 08-hybrid-connectivity: Cloud router imported"
echo "  - 06-dns-records: DNS records imported"