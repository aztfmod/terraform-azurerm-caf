variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}
variable "settings" {
  type = any
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "diagnostics" {
  type = any
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "express_route_circuit_id" {
  type = any
}
variable "authorization_key" {
  type = any
}
variable "virtual_network_gateway_id" {
  type = any
}
variable "local_network_gateway_id" {
  type = any
}



