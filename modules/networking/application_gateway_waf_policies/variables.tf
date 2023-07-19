variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where to create the resource."
  default     = null
}
variable "location" {
  type        = string
  description = "location of the resource"
  default     = null
}
variable "resource_group" {
  type        = any
  description = "Resource group object to deploy the virtual machine"
}
variable "settings" {
  type = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
