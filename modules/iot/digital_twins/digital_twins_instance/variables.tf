variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}

variable "tags" {
  description = "(Required) map of tags for the Digital Twins Instance"
}

variable "name" {
  description = "(Required) Name of the Digital Twins Instance"
}

variable "location" {
  type        = string
  description = "(Required) Resource Location"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group of the Digital Twins Instance"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}