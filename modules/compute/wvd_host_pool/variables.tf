variable "settings" {}
variable "global_settings" {}
variable "resource_group" {
  description = "Resource group object"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "wvd_host_pools" {
  default = {}
}
variable "name" {
  default = {}
}
variable "diagnostic_profiles" {
  default = {}
}
variable "diagnostics" {}