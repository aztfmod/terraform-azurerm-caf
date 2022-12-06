variable "client_config" {
  type = any
}
variable "resource_group" {
  type        = any
  description = "(Required) Map of the resource groups to create"
}
variable "virtual_network_name" {
  type        = any
  description = "name of the parent virtual network"
}

variable "subnets" {
  type        = any
  description = "map structure for the subnets to be created"
}

variable "tags" {
  type        = any
  description = "tags of the resource"
}

variable "location" {
  type        = string
  description = "location of the resource"
}

variable "diagnostics" {
  type = any

}

variable "application_security_groups" {
  type    = any
  default = {}
}

variable "network_security_group_definition" {
  type    = any
  default = {}
}

variable "link_nsg_to_subnet" {
  type    = bool
  default = true
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
  description = "Network Security Group created with different Resource Group"
}