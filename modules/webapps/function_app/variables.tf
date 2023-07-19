variable "settings" {
  type = any
}

variable "global_settings" {
  type = any

}

variable "location" {
  type        = string
  description = "Resource Location"
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "Resource group of the App Service"
  default     = null
}

variable "tags" {
  type        = any
  description = "map of tags for the deployment"
  default     = null
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}

variable "app_service_plan_id" {
  type    = string
  default = null
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
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
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
