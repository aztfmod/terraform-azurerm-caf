
variable "resource_group_name" {
  description = "(Required) Name of the resource group where to create the resource. Changing this forces a new resource to be created. "
  type        = string
}

variable "location" {
  description = "(Required) Specifies the Azure location to deploy the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "diagnostics" {
  description = "(Required) Diagnostics object with the definitions and destination services"
}

variable "settings" {
  description = "(Required) configuration object describing the networking configuration, as described in README"
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "network_watchers" {
  description = "Optional - Network Watches Object"
  default     = {}
}

variable "client_config" {
  description = "client_config object (see module README.md)"
}

variable "application_security_groups" {
  description = "Application Security Groups to attach the NSG"
  default     = {}
}