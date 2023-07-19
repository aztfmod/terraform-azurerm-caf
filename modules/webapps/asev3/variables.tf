variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "settings" {
  type = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "subnet_id" {}
variable "location" {
  type        = string
  description = "(Required) Resource Location"
  default     = null
}
variable "resource_group_name" {
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
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
