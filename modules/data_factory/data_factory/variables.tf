variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  type        = string
  description = "Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group to deploy the virtual machine"
  default     = null
}
variable "resource_groups" {
  type        = any
  description = "combined objetcs of the resource groups. Either resource_group_name or resource_groups is required."
  default     = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "settings" {
  type = any
}
variable "diagnostic_profiles" {
  type    = any
  default = {}
}
variable "diagnostics" {
  type    = any
  default = {}
}
variable "remote_objects" {
  type = any
}
variable "tags" {
  type        = any
  default     = null
  description = "(Optional) A mapping of tags to assign to the resource"
}

