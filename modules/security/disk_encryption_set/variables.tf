variable "global_settings" {
  type = any

}
variable "client_config" {
  type = map(any)
}
variable "base_tags" {
  default = {}
}
variable "settings" {
  type = any
}
variable "keyvault_id" {}
variable "key_vault_key_id" {}
variable "resource_group_name" {}
variable "location" {}