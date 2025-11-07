locals {
  # Core VPC self link
  core_vpc_self_link = data.terraform_remote_state.networking_core.outputs.main_vpc_self_link
  
  # DMZ VPC self link
  dmz_vpc_self_link = data.terraform_remote_state.networking_dmz.outputs.dmz_vpc_self_link
  
  # Host project IDs
  core_project_id = data.terraform_remote_state.project_setup.outputs.host_project_id
  dmz_project_id  = data.terraform_remote_state.networking_dmz.outputs.dmz_host_project_id
}