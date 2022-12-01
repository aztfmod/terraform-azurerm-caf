variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "settings" {
  type = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "tags" {
  type    = map(any)
  default = {}
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "front_door_waf_policies" {
  default = {}
}

