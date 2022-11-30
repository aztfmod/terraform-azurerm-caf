variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "settings" {
  type        = any
  description = "Configuration object for the Automation account."
  # # optional fields supported after TF14
  # type = object({
  #   name                        = string
  #   resource_group_key          = string
  #   tags                        = optional(map(string))
  # })
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}

variable "diagnostics" {}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "remote_objects" {
  type        = map(any)
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}

variable "client_config" {
  type = map(any)
}
variable "private_endpoints" {}