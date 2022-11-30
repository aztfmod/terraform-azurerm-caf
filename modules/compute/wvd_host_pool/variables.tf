variable "settings" {
  type = any
}
variable "global_settings" {
  type = any

}
variable "location" {
  type = string
}
variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group to deploy the virtual machine"
}
variable "base_tags" {}
variable "wvd_host_pools" {
  default = {}
}
variable "name" {
  type = string
  #  default = {}
}
variable "diagnostic_profiles" {
  default = {}
}
variable "diagnostics" {
  type = map(any)
}
