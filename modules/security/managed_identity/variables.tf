variable "client_config" {
  type        = map(any)
  description = "Client configuration object"
}
variable "name" {}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "settings" {
  type = any
}
variable "tags" {
  default = null
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "resource_group_name" {
  description = "Name of the existing resource group to deploy the resource"
}