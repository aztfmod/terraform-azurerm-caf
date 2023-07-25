variable "settings" {}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
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

variable "name" {
  description = "(Required) Name of the App Config"
}

variable "combined_objects" {
  default = {}
}

variable "client_config" {}
variable "vnets" {
  default = {}
}
variable "private_dns" {
  default = {}
}