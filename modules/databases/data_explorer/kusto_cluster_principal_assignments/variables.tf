variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "resource_group_name" {
  description = "Name of the existing resource group to deploy the virtual machine"
}
variable "settings" {
  description = "Settings configuration object (see module README.md)."
}
variable "principal_id" {
  description = "(Required) The object id of the principal. Changing this forces a new resource to be created."
}
variable "tenant_id" {
  description = "(Required) The tenant id in which the principal resides. Changing this forces a new resource to be created."
}