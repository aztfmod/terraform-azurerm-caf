variable "global_settings" {}
variable "settings" {}
variable "client_config" {}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}
variable "resource_group" {
  description = "Resource group object."
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}

variable "location" {
  description = "Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = null
}
variable "diagnostic_profiles" {
  default = null
}
variable "diagnostics" {
  default = null
}