variable "resource_group_name" {
  description = "The name of the resource group where to create the resource."
  type        = string
}

variable "global_settings" {
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