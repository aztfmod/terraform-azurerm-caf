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
variable "keyvault_id" {
  type = string
}
variable "key_vault_key_id" {}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}