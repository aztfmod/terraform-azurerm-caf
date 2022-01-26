variable "client_config" {}
variable "resource_group" {
  description = "(Required) Map of the resource groups to create"
  type        = string
}
variable "virtual_network_name" {
  description = "name of the parent virtual network"
}

variable "subnets" {
  description = "map structure for the subnets to be created"
}

variable "tags" {
  description = "tags of the resource"
}

variable "location" {
  description = "location of the resource"
}

variable "diagnostics" {

}

variable "application_security_groups" {
  default = {}
}

variable "network_security_group_definition" {
  default = {}
}

variable "link_nsg_to_subnet" {
  default = true
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "network_watchers" {
  default = {}
}

variable "network_security_groups" {
  default     = {}
  description = "Network Security Group created with different Resource Group"
}