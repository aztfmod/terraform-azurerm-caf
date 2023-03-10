variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {}
variable "vnets" {
  default = {}
}
variable "azuread_groups" {
  default = {}
}
variable "managed_identities" {
  default = {}
}
# For diagnostics settings
variable "diagnostics" {
  default = {}
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