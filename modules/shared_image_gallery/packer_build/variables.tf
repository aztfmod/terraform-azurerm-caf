variable "resource_group_name" {
  type = string
}
variable "build_resource_group_name" {
  type    = any
  default = {}
}
variable "location" {
  type = string
}
variable "client_config" {
  type = any
}
variable "global_settings" {
  type = any

}
variable "settings" {
  type = any
}
variable "base_tags" {
  type = map(any)
}
variable "gallery_name" {
  type = any
}
variable "image_name" {
  type = any
}
variable "key_vault_id" {
  type = any
}
variable "tenant_id" {
  type = string
}
variable "subscription" {
  type = any
}
variable "managed_identities" {
  type    = any
  default = {}
}
variable "vnet_name" {
  type    = any
  default = {}
}
variable "subnet_name" {
  type    = any
  default = {}
}
