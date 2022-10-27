variable "resource_group" {
  description = "(Required) The resource id of the resource group in which to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "resource_group_name" {}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "base_tags" {}
variable "client_config" {}
variable "diagnostic_profiles" {}
variable "combined_diagnostics" {}
variable "combined_resources" {
  description = "Provide a map of combined resources for environment_variables_from_resources"
  default     = {}
}
variable "global_settings" {}
variable "settings" {}
variable "dynamic_keyvault_secrets" {
  description = "Provide credenrials for private image registries"
  default     = {}
}
