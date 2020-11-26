variable global_settings {}
variable client_config {}
variable location {}
variable resource_group_name {
  description = "Name of the existing resource group to deploy the virtual machine"
}
variable base_tags {}
variable tags {
  default = null
}
variable name {}