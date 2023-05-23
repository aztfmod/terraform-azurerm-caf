variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "settings" {
  type        = any
  description = "(Required) Used to handle passthrough paramenters."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to deploy the Azure B2C Tenant"
  default     = null
}

variable "resource_group" {
  type        = any
  description = "Resource group object to deploy the Azure B2C Tenant"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
