variable "settings" {
  type = any
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "location" {
  type        = string
  description = "location of the resource if different from the resource group."
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
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "name" {
  type        = string
  description = "(Required) Name of the App Config"
}
variable "combined_objects" {
  type    = any
  default = {}
}

variable "client_config" {
  type = any
}
