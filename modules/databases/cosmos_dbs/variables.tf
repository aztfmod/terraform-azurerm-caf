variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "settings" {
  type = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "private_endpoints" {}
variable "resource_groups" {}
variable "private_dns" {
  default = {}
}
variable "vnets" {}