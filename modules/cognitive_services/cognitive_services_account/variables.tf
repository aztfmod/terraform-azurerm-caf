variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "private_dns" {
  default = {}
}

variable "private_endpoints" {
  default = {}
}

variable "resource_group_name" {
  description = "Name of the existing resource group to deploy to"
  type        = string
}

variable "resource_groups" {}

variable "settings" {}

variable "tags" = {
  var.tags
}

variable "vnets" {}
