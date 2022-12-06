variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "tags" {
  type        = any
  description = "(Required) Map of tags to be applied to the resource"
}
variable "settings" {
  type = any
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
