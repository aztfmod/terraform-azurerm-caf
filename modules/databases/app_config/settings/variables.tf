variable "resource_group_name" {
  description = "The name of the resource group where to create the resource."
  type        = string
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "tags" {
  description = "Map of tags to be applied to the resource"
  type        = map(any)
}

variable "app_config_id" {
  type        = string
  description = "App Config Resource Id"
}

variable "client_config" {}
variable "config_settings" {}
variable "keyvaults" {}
