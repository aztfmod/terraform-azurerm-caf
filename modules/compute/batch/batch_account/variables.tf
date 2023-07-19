variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "diagnostics" {
  type    = any
  default = {}
}
variable "settings" {
  type = any
}
variable "keyvault" {
  type    = any
  default = null
}
variable "key_vault_key_id" {
  type    = any
  default = null
}
variable "storage_account_id" {
  type    = string
  default = null
}
variable "storage_account_authentication_mode" {
  default = null
}
variable "private_endpoints" {
  type    = any
  default = {}
}
variable "location" {
  type        = string
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "remote_objects" {}
