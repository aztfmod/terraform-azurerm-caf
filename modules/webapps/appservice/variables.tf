variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "name" {
  description = "(Required) Name of the App Service"
}

variable "location" {
  description = "(Required) Resource Location"
  default     = null
}
variable "resource_group_name" {
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}

variable "app_service_plan_id" {
}

variable "identity" {
  default = null
}

variable "connection_strings" {
  default = {}
}

variable "app_settings" {
  default = null
}

variable "dynamic_app_settings" {
  default = {}
}

variable "slots" {
  default = {}
}

variable "application_insight" {
  default = null
}

variable "settings" {}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}

variable "combined_objects" {
  default = {}
}
variable "storage_accounts" {
  default = {}
}

variable "diagnostic_profiles" {
  default = {}
}
variable "diagnostics" {
  default = null
}

variable "vnets" {}
variable "subnet_id" {}
variable "private_endpoints" {}
variable "private_dns" {}
variable "azuread_applications" {}
variable "azuread_service_principal_passwords" {}
