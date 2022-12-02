variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  type        = string
  description = "(Required) The Azure Region where the Integration Service Environment should exist"
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group where the Integration Service Environment should exist"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}

variable "settings" {
  type = any
}
#variable "name" {
#type = string
#  description = "(Required) The name of the Integration Service Environment"
#}




#variable "sku_name" {
#  description = "(Required) The sku name and capacity of the Integration Service Environment"
#}

#variable "access_endpoint_type" {
#  description = "(Required) The type of access endpoint to use for the Integration Service Environment"
#}
variable "vnets" {
  type        = any
  default     = {}
  description = "(Required) A list of virtual network subnet ids to be used by Integration Service Environment"
}
variable "tags" {
  type        = any
  description = "(Required) map of tags for the deployment"
  default     = null
}
