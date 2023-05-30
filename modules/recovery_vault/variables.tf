
variable "settings" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "diagnostics" {}
variable "private_endpoints" {}
variable "vnets" {}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "identity" {
  default = null
}
variable "private_dns" {
  default = {}
}
variable "resource_group" {
  description = "Resource group object"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
