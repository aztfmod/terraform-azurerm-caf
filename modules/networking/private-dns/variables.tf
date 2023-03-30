variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "name" {
}

variable "resource_group_name" {
  default = null
}

variable "resource_group" {
  default = {}
}

variable "records" {
}

variable "vnet_links" {
  default = {}
}

variable "vnets" {
  default = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "tags" {
  default = {}
}