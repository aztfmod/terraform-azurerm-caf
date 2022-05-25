variable "settings" {}
variable "global_settings" {}
variable "location" {}
variable "resource_group_name" {
  description = "Name of the existing resource group to deploy the virtual machine"
}
variable "base_tags" {}
variable "wvd_workspaces" {
  default = {}
}
variable "name" {
  default = {}
}
variable "diagnostic_profiles" {
  default = {}
}
variable "diagnostics" {}