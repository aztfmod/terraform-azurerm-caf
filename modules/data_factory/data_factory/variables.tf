variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
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
  type    = map(any)
  default = {}
}
variable "diagnostics" {
  type    = map(any)
  default = {}
}
variable "remote_objects" {
  type = map(any)
}
variable "tags" {
  type        = map(any)
  default     = null
  description = "(Optional) A mapping of tags to assign to the resource"
}

