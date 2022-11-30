variable "settings" {
  type = any
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "tags" {
  description = "(Required) map of tags for the deployment"
  type        = map(any)
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "name" {
  description = "(Required) Name of the App Config"
}

variable "combined_objects" {
  default = {}
}

variable "client_config" {
  type = map(any)
}