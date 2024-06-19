variable "resource_group_name" {
  description = "(Required) Name of the resource group to create the hub resources"
  type        = string
}

variable "location" {
  description = "(Required) Location where to create the hub resources"
  type        = string
}
variable "tags" {
  type    = map(any)
  default = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "global_settings" {
  description = "global settings"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {}
variable "virtual_networks" {}
variable "public_ip_addresses" {}
