variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "settings" {
  type        = any
  description = "Configuration object for the database migration service. Refer to documentation for details."
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "remote_objects" {
  type        = any
  description = "Combined objects for virtual networks used in the module."
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
