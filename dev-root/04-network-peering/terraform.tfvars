# Project configuration
project_id = "visa-gcp-network"

# VPC Peering connections configuration
vpc_peering_connections = {
  core_to_dmz = {
    peering_name         = "dev-core-to-dmz"
    local_vpc_link       = "projects/visa-gcp-network/global/networks/dev-shared-vpc"
    peer_vpc_link        = "projects/visa-gcp-network/global/networks/dev-dmz-vpc"
    import_custom_routes = true
    export_custom_routes = true
  }
  dmz_to_core = {
    peering_name         = "dev-dmz-to-core"
    local_vpc_link       = "projects/visa-gcp-network/global/networks/dev-dmz-vpc"
    peer_vpc_link        = "projects/visa-gcp-network/global/networks/dev-shared-vpc"
    import_custom_routes = true
    export_custom_routes = true
  }
  test_vpc_1_to_2 = {
    peering_name         = "test-vpc-1-to-test-vpc-2"
    local_vpc_link       = "projects/visa-gcp-network/global/networks/test-vpc-1"
    peer_vpc_link        = "projects/visa-gcp-network/global/networks/test-vpc-2"
    import_custom_routes = false
    export_custom_routes = false
  }
  test_vpc_2_to_1 = {
    peering_name         = "test-vpc-2-to-test-vpc-1"
    local_vpc_link       = "projects/visa-gcp-network/global/networks/test-vpc-2"
    peer_vpc_link        = "projects/visa-gcp-network/global/networks/test-vpc-1"
    import_custom_routes = false
    export_custom_routes = false
  }
}