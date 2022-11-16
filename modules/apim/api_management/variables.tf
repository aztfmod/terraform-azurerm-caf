variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "vnets" {
  description = "Virtual networks configuration object"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  description = "(Required) Used to handle passthrough paramenters."
}
variable "location" {
  description = "(Required) Region in which the resource will be deployed"
}
variable "remote_objects" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
  default     = {}
}
variable "resource_group_name" {
  description = " The name of the Resource Group in which the API Management Service should be exist. Changing this forces a new resource to be created."
}
