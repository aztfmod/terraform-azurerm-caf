variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}

variable "tags" {
  type        = any
  description = "(Required) map of tags for the deployment"
}

variable "name" {
  type        = string
  description = "(Required) Name of the App Service"
}

variable "location" {
  type        = string
  description = "(Required) Resource Location"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group of the App Service"
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
  type        = any
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

variable "vnets" {
  type = any
}
variable "subnet_id" {
  type = string
}
variable "private_endpoints" {
  type = any
}
variable "private_dns" {
  type = any
}