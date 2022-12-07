variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}

variable "base_tags" {
  type        = any
  description = "tags of the resource"
}

variable "location" {
  type        = string
  description = "location of the resource"
}
variable "settings" {
  type = any
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
