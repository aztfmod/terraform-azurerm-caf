variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "settings" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "diagnostics" {}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "express_route_circuit_id" {}
variable "authorization_key" {}
variable "virtual_network_gateway_id" {}
variable "local_network_gateway_id" {}



