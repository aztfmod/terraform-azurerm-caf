variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "diagnostics" {
  default = {}
}
variable "settings" {}
variable "resource_group_name" {}
variable "location" {}
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
  default = {}
}
variable "resource_groups" {
  default = {}
}
variable "vnets" {
  default = {}
}
variable "private_dns" {
  default = {}
}
variable "private_endpoints" {
  default = {}
}
