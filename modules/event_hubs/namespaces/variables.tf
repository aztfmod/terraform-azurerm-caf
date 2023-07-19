variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "settings" {
  type = any
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "storage_accounts" {
  type    = any
  default = {}
}
variable "location" {
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "Resource group object to deploy the virtual machine"
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
