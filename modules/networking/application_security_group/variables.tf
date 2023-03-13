variable "location" {
  description = "(Optional) Resource Location"
  default     = null
}
variable "resource_group_name" {
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Enable tags inheritence."
  type        = bool
}
variable "settings" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}