variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type = any
}
variable "resource_groups" {
  type = map(any)
}
variable "private_endpoints" {}
variable "private_dns" {
  type = map(any)
}
variable "remote_objects" {
  type = map(any)
}
variable "vnet" {}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}