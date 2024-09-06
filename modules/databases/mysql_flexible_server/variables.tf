variable "base_tags" {
  description = "(Optional) Base tags for the resource to be inherited from the resource group."
  type        = map(any)
  default     = {}
}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
  default     = {}
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
  default     = {}
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group where the resource should exist. Changing this forces a new resource to be created."
}

variable "remote_objects" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}

variable "settings" {
  description = "(Required) Used to handle passthrough parameters."
  default     = {}
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "private_dns" {
  default = {}
}

variable "private_endpoints" {}

variable "resource_groups" {}

variable "resource_group" {}

variable "vnets" {}

variable "inherit_base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}