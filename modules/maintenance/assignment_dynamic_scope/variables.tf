variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "resource_groups" {
  description = "(Required) The resource group objects where to create the resource."
}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "tags" {
  description = "Tags to be used for this resource deployment."
  type        = map(any)
  default     = {}
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
  default     = {}
}

variable "maintenance_configuration_id" {
  description = "(Required) Specifies the ID of the Maintenance Configuration Resource. Changing this forces a new resource to be created."
  type        = string
}

variable "settings" {
  description = "(Required) The configuration for each module"
}

variable "name" {
  description = "(Required) The name which should be used for this Dynamic Maintenance Assignment. Changing this forces a new Dynamic Maintenance Assignment to be created."
  type        = string
}
