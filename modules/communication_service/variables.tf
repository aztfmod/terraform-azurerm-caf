variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "settings" {}

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Communication Service. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Communication Service. Changing this forces a new resource to be created."
}

variable "data_location" {
  description = "(Optional) The location where the Communication service stores its data at rest. Defaults to United States."
  default     = false
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

variable "diagnostic_profiles" {
  default = {}
}

variable "diagnostics" {
  default = {}
}

variable "resource_groups" {
  default = {}
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
