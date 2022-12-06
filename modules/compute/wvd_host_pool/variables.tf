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
variable "base_tags" {
  type = map(any)
}
variable "wvd_host_pools" {
  type    = any
  default = {}
}
variable "name" {
  type    = any
  default = {}
}
variable "diagnostic_profiles" {
  type    = any
  default = {}
}
variable "diagnostics" {
  type = any
}
