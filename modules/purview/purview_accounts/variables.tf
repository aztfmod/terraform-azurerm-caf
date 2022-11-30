variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type        = any
  description = "(Required) Used to handle passthrough paramenters."
}
variable "remote_objects" {
  type        = map(any)
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
  default     = {}
}
variable "resource_group_name" {
  type        = string
  description = " The name of the Resource Group where the Purview Account should exist. Changing this forces a new Purview Account to be created."
}
variable "location" {
  type = string
}
variable "diagnostics" {
  type = map(any)
}
variable "private_dns" {
  default = {}
}