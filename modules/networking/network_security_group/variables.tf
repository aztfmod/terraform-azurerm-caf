
variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the resource group where to create the resource. Changing this forces a new resource to be created. "
}

variable "location" {
  type        = string
  description = "(Required) Specifies the Azure location to deploy the resource. Changing this forces a new resource to be created."
}

variable "diagnostics" {
  type        = any
  description = "(Required) Diagnostics object with the definitions and destination services"
}

variable "settings" {
  type        = any
  description = "(Required) configuration object describing the networking configuration, as described in README"
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "network_watchers" {
  type        = any
  description = "Optional - Network Watches Object"
  default     = {}
}

variable "client_config" {
  type        = any
  description = "client_config object (see module README.md)"
}

variable "application_security_groups" {
  type        = any
  description = "Application Security Groups to attach the NSG"
  default     = {}
}