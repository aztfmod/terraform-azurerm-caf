variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "settings" {}
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
variable "password" {}
variable "keyvault_id" {
  default = null
}
variable "organization_id" {
  default = null
}
variable "provider_name" {
  default = null
}
variable "account_id" {
  default = null
}
variable "issuer_name" {
  default = null
}