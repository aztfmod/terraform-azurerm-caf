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
  type = any
}

variable "tags" {
  type        = any
  description = "(Required) map of tags for the deployment"
}

variable "name" {
  type        = string
  description = "(Required) Name of the App Service"
}


variable "storage_account_access_key" {
  type    = any
  default = null
}

variable "storage_account_name" {
  type    = any
  default = null
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

variable "slots" {
  type    = any
  default = {}
}

variable "application_insight" {
  type    = any
  default = null
}

variable "base_tags" {
  type = map(any)
}

variable "combined_objects" {
  type    = any
  default = {}
}

variable "client_config" {
  type = any
}

variable "dynamic_app_settings" {
  type    = any
  default = {}
}

variable "remote_objects" {
  type    = any
  default = null
}
