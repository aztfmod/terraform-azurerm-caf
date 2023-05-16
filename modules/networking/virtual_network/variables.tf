variable "client_config" {
  type = any
}
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group where to create the resource. Changing this forces a new resource to be created. "
  default     = null
}

variable "location" {
  type        = string
  description = "location of the resource if different from the resource group."
  default     = null
}

variable "tags" {
  type        = any
  description = "(Required) map of tags for the deployment"
}

variable "diagnostics" {
  type        = any
  description = "(Required) Diagnostics object with the definitions and destination services"
}

variable "settings" {
  type        = any
  description = "(Required) configuration object describing the networking configuration, as described in README"
}

variable "application_security_groups" {
  type    = any
  default = {}
}

variable "network_security_group_definition" {
  type = any
}

variable "netwatcher" {
  type        = any
  description = "(Optional) is a map with two attributes: name, rg who describes the name and rg where the netwatcher was already deployed"
  default     = {}
}

variable "ddos_id" {
  type        = string
  description = "(Optional) ID of the DDoS protection plan if exists"
  default     = ""
}

variable "route_tables" {
  type    = any
  default = {}
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "network_watchers" {
  type    = any
  default = {}
}
variable "network_security_groups" {
  type        = any
  default     = {}
  description = "Network Security Group cretaed with different Resource Group"
}
variable "remote_dns" {
  type    = any
  default = {}
}

variable "resource_group" {
  type        = any
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
