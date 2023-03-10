variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {}
variable "keyvault_id" {}
variable "storage_accounts" {}
variable "azuread_groups" {}
variable "vnets" {}
variable "subnet_id" {}
variable "private_endpoints" {}
variable "diagnostic_profiles" {
  default = {}
}
variable "network_security_group_definition" {
  default = null
}
variable "diagnostics" {
  default = {}
}
variable "resource_group" {
  description = "Resource group object"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "private_dns" {
  default = {}
}
variable "virtual_subnets" {}
