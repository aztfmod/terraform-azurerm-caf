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
variable "resource_group_name" {
  type        = string
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "keyvault_id" {
  type = string
}
variable "storage_accounts" {
  type = any
}
variable "azuread_groups" {
  type = any
}
variable "vnets" {
  type = any
}
variable "subnet_id" {
  type = string
}
variable "private_endpoints" {
  type = any
}
variable "private_dns" {
  type    = any
  default = {}
}
variable "network_security_group_definition" {
  default = null
}
variable "diagnostics" {
  type    = any
  default = {}
}
variable "diagnostic_profiles" {
  type    = any
  default = {}
}
variable "virtual_subnets" {
  type = any
}
variable "location" {
  type        = string
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "resource_group" {
  type        = any
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
