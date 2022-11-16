variable "resource_group_name" {}
variable "build_resource_group_name" {
  default = {}
}
variable "location" {}
variable "client_config" {}
variable "global_settings" {}
variable "settings" {}
variable "base_tags" {}
variable "gallery_name" {}
variable "image_name" {}
variable "key_vault_id" {}
variable "tenant_id" {}
variable "subscription" {}
variable "managed_identities" {
  default = {}
}
variable "vnet_name" {
  default = {}
}
variable "subnet_name" {
  default = {}
}


