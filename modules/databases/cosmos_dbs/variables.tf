variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
  default     = null
}
variable "settings" {
  type = any
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "private_endpoints" {
  type = any
}
variable "resource_groups" {
  type = any
}
variable "private_dns" {
  type    = any
  default = {}
}
variable "vnets" {
  type = any
}
variable "resource_group" {
  type        = any
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
