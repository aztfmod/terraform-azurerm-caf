variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "name" {
  description = "(Required) Name of the IP Group to be created"
}

variable "tags" {
  description = "(Required) Tags of the IP Group to be created"
}

variable "resource_group_name" {
  description = "(Required) Resource Group name of the IP Group to be created"
}

variable "location" {
  description = "(Required) Location of the IP Group to be created"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "vnet" {
  description = "(Required) Vnet CIDRs of the IP Group to be created"
}

variable "settings" {}

variable "client_config" {}
