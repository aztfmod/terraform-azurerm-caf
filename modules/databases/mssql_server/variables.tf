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
  description = "The name of the resource group where to create the resource."
  default     = null
}
variable "location" {
  type        = string
  description = "Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = null
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
variable "private_endpoints" {
  type = any
}
variable "resource_group" {
  type        = any
  description = "Resource group object"
}
variable "resource_groups" {
  type        = any
  description = "Map of resource group objects by landing zone"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "private_dns" {
  type    = any
  default = {}
}
variable "keyvault_id" {
  type = string
}
variable "remote_objects" {
  type = any
}
variable "diagnostics" {
  type = any
}

variable "managed_identities" {
  type    = any
  default = {}
}
