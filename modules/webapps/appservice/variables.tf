variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}

variable "name" {
  type        = string
  description = "(Required) Name of the App Service"
}

variable "location" {
  type        = string
  description = "(Required) Resource Location"
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  type        = any
  description = "Resource group object to deploy the virtual machine"
}

variable "app_service_plan_id" {
  type = any
}

variable "identity" {
  type    = any
  default = null
}

variable "connection_strings" {
  type    = any
  default = {}
}

variable "app_settings" {
  type    = any
  default = null
}

variable "dynamic_app_settings" {
  type    = any
  default = {}
}

variable "slots" {
  type    = any
  default = {}
}

variable "application_insight" {
  type    = any
  default = null
}

variable "settings" {
  type = any
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}

variable "combined_objects" {
  type    = any
  default = {}
}
variable "storage_accounts" {
  type    = any
  default = {}
}

variable "diagnostic_profiles" {
  type    = any
  default = {}
}
variable "diagnostics" {
  type    = any
  default = null
}

variable "vnets" {}
variable "subnet_id" {}
variable "private_endpoints" {}
variable "private_dns" {}
variable "azuread_applications" {}
variable "azuread_service_principal_passwords" {}
