variable "client_config" {
  type        = any
  description = "Client configuration object"
}
variable "name" {
  type = string
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "settings" {
  type = any
}
variable "tags" {
  type    = any
  default = null
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}
variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group to deploy the resource"
}