variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "settings" {}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "subnet_id" {}
variable "location" {
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
  default = {}
}
variable "diagnostics" {
  default = null
}
variable "diagnostic_profiles" {
  default = null
}
