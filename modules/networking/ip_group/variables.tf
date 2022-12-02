variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "name" {
  type        = string
  description = "(Required) Name of the IP Group to be created"
}

variable "tags" {
  type        = any
  description = "(Required) Tags of the IP Group to be created"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource Group name of the IP Group to be created"
}

variable "location" {
  type        = string
  description = "(Required) Location of the IP Group to be created"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}

variable "vnet" {
  type        = any
  description = "(Required) Vnet CIDRs of the IP Group to be created"
}

variable "settings" {
  type = any
}

variable "client_config" {
  type = any
}
