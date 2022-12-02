variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "settings" {
  type = any
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "diagnostics" {
  type = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}
variable "private_endpoints" {
  type = any
}
variable "vnets" {
  type = any
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "resource_groups" {
  type = any
}
variable "identity" {
  type    = any
  default = null
}
variable "private_dns" {
  type    = any
  default = {}
}