variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}

variable "virtual_network_id" {
  type = any
}

variable "private_dns" {
  type = any
}

variable "settings" {
  type = any
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "tags" {
  type    = any
  default = {}
}