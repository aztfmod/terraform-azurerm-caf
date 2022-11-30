variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type = any
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "keyvault_id" {}
variable "storage_accounts" {}
variable "azuread_groups" {}
variable "vnets" {}
variable "subnet_id" {}
variable "private_endpoints" {}
variable "resource_groups" {}
variable "diagnostic_profiles" {
  default = {}
}
variable "diagnostics" {
  default = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "private_dns" {
  default = {}
}
