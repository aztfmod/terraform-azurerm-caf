variable "app_service_plan_id" {
}

variable "app_settings" {
  default = null
}

variable "application_insight" {
  default = null
}

variable "azuread_applications" {
}

variable "azuread_service_principal_passwords" {
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "combined_objects" {
  default = {}
}

variable "connection_string" {
  default = {}
}

variable "diagnostic_profiles" {
  default = {}
}

variable "diagnostics" {
  default = null
}

variable "dynamic_app_settings" {
  default = {}
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "identity" {
  default = null
}

variable "location" {
  description = "(Required) Resource Location"
  default     = null
}

variable "name" {
  description = "(Required) Name of the App Service"
}

variable "private_dns" {
}

variable "private_endpoints" {
}

variable "remote_objects" {
  default = null
}

variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}

variable "resource_group_name" {
  description = "Resource group object to deploy the virtual machine"
  default     = null
}

variable "settings" {
}

variable "storage_accounts" {
  default = {}
}

variable "subnet_id" {
}

variable "virtual_subnets" {
}

variable "vnets" {
}
