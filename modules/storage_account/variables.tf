variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "storage_account" {
  type = any
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "vnets" {
  type    = any
  default = {}
}
variable "private_endpoints" {
  type    = any
  default = {}
}
variable "resource_groups" {
  type    = any
  default = {}
}
variable "base_tags" {
  type    = map(any)
  default = {}
}
variable "recovery_vaults" {
  type    = any
  default = {}
}
variable "private_dns" {
  type    = any
  default = {}
}

variable "diagnostic_profiles" {
  type    = any
  default = {}
}

variable "diagnostics" {
  type    = any
  default = {}
}

variable "managed_identities" {
  type    = any
  default = {}
}
