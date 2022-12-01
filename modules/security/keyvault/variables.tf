variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "resource_groups" {
  type = map(any)
}
variable "settings" {
  type = any
}
variable "vnets" {
  type    = map(any)
  default = {}
}
variable "azuread_groups" {
  default = {}
}
variable "managed_identities" {
  type    = map(any)
  default = {}
}
# For diagnostics settings
variable "diagnostics" {
  type    = map(any)
  default = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "private_dns" {
  type    = map(any)
  default = {}
}