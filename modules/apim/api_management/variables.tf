variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "vnets" {
  type        = any
  description = "Virtual networks configuration object"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type        = any
  description = "(Required) Used to handle passthrough paramenters."
}
variable "remote_objects" {
  type        = any
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}
variable "location" {
  type        = string
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which the API Management Service should be exist. Changing this forces a new resource to be created."
  default     = null
}
variable "resource_group" {
  type        = any
  description = "Resource group object"
}
variable "diagnostic_profiles" {
  type        = any
  description = "Diagnostic logging profiles to apply"
  default     = {}
}
variable "diagnostics" {
  type        = any
  description = "Details about the diagnostics"
  default     = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
