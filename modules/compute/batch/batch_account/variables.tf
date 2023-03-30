variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "diagnostics" {
  default = {}
}
variable "settings" {}
variable "keyvault" {
  default = null
}
variable "key_vault_key_id" {
  default = null
}
variable "storage_account_id" {
  default = null
}
variable "storage_account_authentication_mode" {
  default = null
}
variable "private_endpoints" {
  default = {}
}
variable "location" {
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "resource_group_name" {
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "remote_objects" {}