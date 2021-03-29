variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the existing resource group to deploy the virtual machine"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}


variable "application_security_groups" {
  default = {}
}

variable "settings" {
  default = {}
}

variable "network_interface_id" {
  default = {}
}
variable "application_security_group_id" {
  default = {}
}

variable "existing_resources" {
  default = {}
}
