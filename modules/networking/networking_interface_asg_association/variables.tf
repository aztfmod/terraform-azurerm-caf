variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group to deploy the virtual machine"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}


variable "application_security_groups" {
  type    = any
  default = {}
}

variable "settings" {
  type    = any
  default = {}
}

variable "network_interface_id" {
  type    = any
  default = {}
}
variable "application_security_group_id" {
  type    = any
  default = {}
}

variable "existing_resources" {
  type    = any
  default = {}
}
