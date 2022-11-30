variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where to create the resource."
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "tags" {
  description = "Map of tags to be applied to the resource"
  type        = map(any)
}

variable "key_values" {
  type        = list(string)
  description = "App Config Setting Values List"
}

variable "key_names" {
  type        = list(string)
  description = "App Config Setting Key Names"
}

variable "config_name" {
  type        = string
  description = "App Config Resource Name"
}