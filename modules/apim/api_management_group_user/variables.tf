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
  description = " The name of the API Management Service. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  description = " The name of the Resource Group in which the API Management Service exists. Changing this forces a new resource to be created."
}

variable "group_name" {
  description = "The Name of the API Management Group within the API Management Service. Changing this forces a new resource to be created."
}

variable "user_id" {
  description = "The ID of the API Management User which should be assigned to this API Management Group. Changing this forces a new resource to be created."
}