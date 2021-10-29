variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {}
variable "settings" {}
variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the subnet."
  type        = string
}
variable "virtual_network_name" {
  description = "(Required) The name of the virtual network to which to attach the subnet."
}
variable "network_security_groups" {
  default = {}
}
variable "network_security_group_definition" {
  default = {}
}
variable "route_tables" {
  default = {}
}