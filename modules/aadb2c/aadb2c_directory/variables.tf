variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "settings" {
  description = "(Required) Used to handle passthrough paramenters."
}

variable "resource_group_name" {
  description = "Name of the resource group to deploy the Azure B2C Tenant"
  default     = null
}

variable "resource_group" {
  description = "Resource group object to deploy the Azure B2C Tenant"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}