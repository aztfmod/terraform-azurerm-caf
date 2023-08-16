variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "settings" {
}

variable "resource_group" {
}

variable "resource_group_name" {
  default = ""
}

variable "location" {
}

variable "virtual_network_id" {
}
variable "inherit_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}