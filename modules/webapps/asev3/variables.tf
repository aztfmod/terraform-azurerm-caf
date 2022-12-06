variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "settings" {
  type = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "subnet_id" {
  type = string
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "location" {
  type        = string
  description = "(Required) Resource Location"
}
variable "private_dns" {
  type    = any
  default = {}
}
variable "diagnostics" {
  type    = any
  default = null
}
variable "diagnostic_profiles" {
  type    = any
  default = null
}
