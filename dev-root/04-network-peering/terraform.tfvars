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
}