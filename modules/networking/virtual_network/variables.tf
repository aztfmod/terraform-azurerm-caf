variable "client_config" {
  type = map(any)
}
variable "resource_group_name" {
  type        = string
  description = "(Required) Name of the resource group where to create the resource. Changing this forces a new resource to be created. "
}

variable "location" {
  type        = string
  description = "(Required) Specifies the Azure location to deploy the resource. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = map(any)
  description = "(Required) map of tags for the deployment"
}

variable "diagnostics" {
  type        = map(any)
  description = "(Required) Diagnostics object with the definitions and destination services"
}

variable "settings" {
  type        = any
  description = "(Required) configuration object describing the networking configuration, as described in README"
}

variable "application_security_groups" {
  default = {}
}

variable "network_security_group_definition" {}

variable "netwatcher" {
  description = "(Optional) is a map with two attributes: name, rg who describes the name and rg where the netwatcher was already deployed"
  default     = {}
}

variable "ddos_id" {
  description = "(Optional) ID of the DDoS protection plan if exists"
  default     = ""
}

variable "route_tables" {
  default = {}
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
  default = {}
}
variable "network_security_groups" {
  default     = {}
  description = "Network Security Group cretaed with different Resource Group"
}

variable "remote_dns" {
  default = {}
}