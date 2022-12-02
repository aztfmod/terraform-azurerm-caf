variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type        = any
  description = "(Required) Used to handle passthrough paramenters."
}
variable "remote_objects" {
  type        = any
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
  default     = {}
}
variable "api_management_name" {
  type        = string
  description = " The name of the API Management Service in which the User should be created. Changing this forces a new resource to be created."
}
variable "resource_group_name" {
  type        = string
  description = " The name of the Resource Group in which the API Management Service exists. Changing this forces a new resource to be created."
}
