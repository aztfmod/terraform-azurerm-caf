variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "location" {
  type        = string
  description = "location of the resource"
}
variable "settings" {
  type = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "tags" {
  default = {}
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

