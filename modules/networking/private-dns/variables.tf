variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "records" {
}

variable "vnet_links" {
  default = {}
}

variable "vnets" {
  type    = map(any)
  default = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "tags" {
  type    = map(any)
  default = {}
}