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
  description = "The name of the resource group where to create the resource."
  default     = null
}

variable "diagnostics" {
  type = any
}

variable "remote_objects" {
  type        = any
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}

variable "client_config" {
  type = any
}
variable "private_endpoints" {
  type = any
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
  type        = any
}
variable "location" {
  type        = string
  description = "Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = null
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
