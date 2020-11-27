variable global_settings {}
variable client_config {}
variable location {}
variable resource_group_name {
  description = "Name of the existing resource group to deploy the virtual machine"
}
variable base_tags {}
variable settings {}
variable availability_sets {}
variable tags {
  default = null
}
variable name {}
variable ppg_id {}
variable proximity_placement_groups {}