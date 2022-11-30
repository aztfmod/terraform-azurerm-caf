variable "settings" {
  type = any
}

variable "global_settings" {
  type = any

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

variable "tags" {
  description = "(Required) map of tags for the deployment"
}

variable "name" {
  description = "(Required) Name of the App Service"
}


variable "storage_account_access_key" {
  default = null
}

variable "storage_account_name" {
  default = null
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

variable "slots" {
  default = {}
}

variable "application_insight" {
  default = null
}

variable "base_tags" {}

variable "combined_objects" {
  default = {}
}

variable "client_config" {
  type = map(any)
}

variable "dynamic_app_settings" {
  default = {}
}

variable "remote_objects" {
  type    = map(any)
  default = null
}
