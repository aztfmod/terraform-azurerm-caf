variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "storage_account" {}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "vnets" {
  type    = map(any)
  default = {}
}
variable "private_endpoints" {
  default = {}
}
variable "resource_groups" {
  default = {}
}
variable "base_tags" {
  default = {}
}
variable "recovery_vaults" {
  default = {}
}
variable "private_dns" {
  default = {}
}

variable "diagnostic_profiles" {
  type    = map(any)
  default = {}
}

variable "diagnostics" {
  type    = map(any)
  default = {}
}

variable "managed_identities" {
  default = {}
}