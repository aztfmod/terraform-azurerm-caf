variable "settings" {
  description = "Configuration object for the Automation account."
  # # optional fields supported after TF14
  # type = object({
  #   name                        = string
  #   resource_group_key          = string
  #   tags                        = optional(map(string))
  # })
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "diagnostics" {}

variable "remote_objects" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}

variable "client_config" {}
variable "private_endpoints" {}
variable "location" {
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "resource_group_name" {
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}