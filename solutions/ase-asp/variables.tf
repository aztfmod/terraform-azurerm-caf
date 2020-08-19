# Map of the remote data state for lower level
variable lowerlevel_storage_account_name {}
variable lowerlevel_container_name {}
variable lowerlevel_key {}
variable lowerlevel_resource_group_name {}
variable workspace {}

variable level {
  default = "level3"
}
variable environment {
  default = "sandpit"
}
variable rover_version {
  default = null
}
variable max_length {
  default = 40
}
variable tags {
  default = null
}
variable app_service_environments {
  default = null
}
variable diagnostics_definition {
  default = null
}
variable resource_groups {
  default = null
}
variable network_security_group_definition {
  default = null
}
variable networking {
  default = null
}