variable global_settings {}
variable storage_account {}
variable resource_group_name {}
variable location {}
variable vnets {
  default = {}
}
variable private_endpoints {
  default = {}
}
variable resource_groups {
  default = {}
}
variable tfstates {
  default = null
}
variable use_msi {
  default = false
}
variable base_tags {
  default = {}
}