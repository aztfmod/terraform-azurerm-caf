variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "resource_groups" {
  description = "combined objetcs of the resource groups. Either resource_group_name or resource_groups is required."
  default     = {}
}
variable "settings" {}
variable "diagnostic_profiles" {
  default = {}
}
variable "diagnostics" {
  default = {}
}
variable "remote_objects" {}
variable "tags" {
  default     = null
  description = "(Optional) A mapping of tags to assign to the resource"
}
variable "location" {
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