variable "settings" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "vpn_gateway_id" {}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "client_config" {}
