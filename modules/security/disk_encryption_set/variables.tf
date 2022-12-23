variable "global_settings" {
  type = any

}
variable "client_config" {
  type = any
}
variable "base_tags" {
  type    = map(any)
  default = {}
}
variable "settings" {
  type = any
}
variable "keyvault_id" {
  type = string
}
variable "key_vault_key_id" {
  type = any
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
