variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {}
variable "settings" {}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "inherit_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "subnet_id" {}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "primary_server_id" {
  default = ""
}
variable "keyvault" {}
variable "vnets" {}
variable "resource_groups" {}
variable "private_endpoints" {}
variable "private_dns" {
  default = {}
}
