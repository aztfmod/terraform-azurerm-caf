variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}

variable "base_tags" {
  description = "tags of the resource"
}

variable "location" {
  description = "location of the resource"
}
variable "settings" {}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}



