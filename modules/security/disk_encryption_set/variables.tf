variable "global_settings" {
  type = any

}
variable "client_config" {}
variable "base_tags" {
  default = {}
}
variable "settings" {}
variable "keyvault_id" {}
variable "key_vault_key_id" {}
variable "resource_group_name" {}
variable "location" {}