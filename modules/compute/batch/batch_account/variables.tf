variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "diagnostics" {
  type    = map(any)
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
  default = null
}
variable "key_vault_key_id" {
  default = null
}
variable "storage_account_id" {
  default = null
}
variable "managed_identities" {
  type    = map(any)
  default = {}
}
variable "resource_groups" {
  type    = map(any)
  default = {}
}
variable "vnets" {
  type    = map(any)
  default = {}
}
variable "private_dns" {
  type    = map(any)
  default = {}
}
variable "private_endpoints" {
  type    = map(any)
  default = {}
}
