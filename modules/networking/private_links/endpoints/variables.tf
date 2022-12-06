variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type = any
}
variable "resource_groups" {
  type = any
}
variable "private_endpoints" {
  type = any
}
variable "private_dns" {
  type = any
}
variable "remote_objects" {
  type = any
}
variable "vnet" {
  type = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}