variable "global_settings" {
  description = "Global settings object (see module README.md)"
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

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "maintenance_configuration_id" {
  description = "(Required) Specifies the ID of the Maintenance Configuration Resource. Changing this forces a new resource to be created."
  type        = string
}

variable "virtual_machine_id" {
  description = "(Required) Specifies the Virtual Machine ID to which the Maintenance Configuration will be assigned. Changing this forces a new resource to be created."
  type        = string
}