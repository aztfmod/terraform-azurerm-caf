variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "server_name" {}
variable "settings" {
  type = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "sourceDatabaseId" {
  default = ""
}