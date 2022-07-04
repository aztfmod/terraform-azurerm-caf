variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "settings" {}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "subnet_id" {}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "location" {
  description = "(Required) Resource Location"
}
variable "private_dns" {
  default = {}
}
variable "diagnostics" {
  default = null
}
variable "diagnostic_profiles" {
  default = null
}
