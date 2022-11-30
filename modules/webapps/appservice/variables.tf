variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}

variable "tags" {
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

variable "settings" {
  type = any
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
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
  type    = map(any)
  default = null
}

variable "vnets" {}
variable "subnet_id" {}
variable "private_endpoints" {}
variable "private_dns" {}