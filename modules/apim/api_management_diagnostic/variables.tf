variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  description = "(Required) Used to handle passthrough paramenters."
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
variable "api_management_name" {
  description = " The Name of the API Management Service where this Diagnostic should be created. Changing this forces a new resource to be created."
}
variable "resource_group_name" {
  description = " The Name of the Resource Group where the API Management Service exists. Changing this forces a new resource to be created."
}
variable "api_management_logger_id" {
  description = " The id of the target API Management Logger where the API Management Diagnostic should be saved."
}
