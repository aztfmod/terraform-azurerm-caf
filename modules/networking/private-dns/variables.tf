variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "records" {
  type = any
}

variable "vnet_links" {
  type    = any
  default = {}
}

variable "vnets" {
  type    = any
  default = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "tags" {
  type    = any
  default = {}
}