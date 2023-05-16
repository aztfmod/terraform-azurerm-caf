
variable "client_config" {
  type = any
}
variable "global_settings" {
  type = any

}
variable "settings" {
  type = any
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
variable "resource_group" {
  type        = any
  description = "Resource group object"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
