variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "tags" {
  description = "(Required) Map of tags to be applied to the resource"
  type        = map(any)
}
variable "settings" {}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
