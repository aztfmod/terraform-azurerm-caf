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
variable "api_management_name" {
  type        = string
  description = " The Name of the API Management Service where this subscription should be created. Changing this forces a new resource to be created."
}
variable "resource_group_name" {
  type        = string
  description = " The Name of the Resource Group where the API Management subscription exists. Changing this forces a new resource to be created."
}
variable "product_id" {
  type        = string
  description = "The ID of the API Management Product within the API Management Service. Changing this forces a new resource to be created."
}
