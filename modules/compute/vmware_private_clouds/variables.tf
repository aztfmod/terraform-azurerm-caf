variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "settings" {
  type = any
}
variable "tags" {
  type    = map(any)
  default = null
}
variable "keyvaults" {
  type        = map(any)
  description = "Keyvault to store the nsxt_password and the vcenter_password"
  default     = {}
}
variable "dynamic_keyvault_secrets" {
  description = "Keyvault Secret to store the nsxt_password and the vcenter_password"
  default     = {}
}