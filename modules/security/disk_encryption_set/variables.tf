variable "global_settings" {}
variable "client_config" {}
variable "base_tags" {
  default = {}
}
variable "settings" {}
variable "keyvault_id" {
  default = null
}
variable "key_vault_key_id" {}
variable "resource_group_name" {}
variable "location" {}
variable "managed_identities" {}
