
variable "diagnostics" {
  type = any
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
variable "gallery_name" {
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
