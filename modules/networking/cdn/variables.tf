variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}

variable "settings" {}

variable "endpoints" {}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "diagnostic_profiles" {
  default = null
}

variable "diagnostics" {
  default = null
}

variable "storage_accounts" {
  default = {}
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "client_config" {
  description = "Client Config"
  type        = map(any)
}

variable "location" {
  description = "(Optional) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
  default     = "Global"
}

