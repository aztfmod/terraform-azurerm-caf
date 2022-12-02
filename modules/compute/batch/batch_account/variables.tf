variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}
variable "diagnostics" {
  type    = any
  default = {}
}
variable "settings" {
  type = any
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
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
variable "managed_identities" {
  type    = any
  default = {}
}
variable "resource_groups" {
  type    = any
  default = {}
}
variable "vnets" {
  type    = any
  default = {}
}
variable "private_dns" {
  type    = any
  default = {}
}
variable "private_endpoints" {
  type    = any
  default = {}
}
