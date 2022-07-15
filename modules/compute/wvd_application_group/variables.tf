variable "settings" {}
variable "global_settings" {}
variable "location" {}
variable "resource_group_name" {
  description = "Name of the existing resource group to deploy the virtual machine"
}
variable "base_tags" {}
variable "wvd_host_pools" {
  default = {}
}
variable "name" {
  default = {}
}
variable "host_pool_id" {
  default = {}
}
variable "workspace_id" {
  default = {}
}

variable "key_vault_id" {
  default = {}
}

variable "diagnostic_profiles" {
  default = {}
}
variable "diagnostics" {}
