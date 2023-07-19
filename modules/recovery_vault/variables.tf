variable "settings" {
  type = any
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "diagnostics" {
  type = any
}
variable "private_endpoints" {
  type = any
}
variable "vnets" {
  type = any
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "identity" {
  type    = any
  default = null
}
variable "private_dns" {
  type    = any
  default = {}
}
variable "resource_group" {
  type        = any
  description = "Resource group object"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
