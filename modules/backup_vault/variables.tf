variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "resource_groups" {
  type = any
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
  type        = map(any)
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "identity" {
  type = any
}
variable "settings" {
  type = any
}
variable "storage_accounts" {
  type = any
}
