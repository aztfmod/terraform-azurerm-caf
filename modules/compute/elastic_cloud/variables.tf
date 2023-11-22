variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "combined_resources" {
  description = "Provide a map of combined resources for environment_variables_from_resources"
  default     = {}
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}
variable "resource_group_name" {
}
variable "resource_group" {
  description = "(Required) The resource id of the resource group in which to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "settings" {}