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
variable "data_factory_id" {
  type        = string
  description = " Specifies the ID of the Data Factory the Azure-SSIS Integration Runtime belongs to. Changing this forces a new resource to be created."
}
variable "resource_group_name" {
  type        = string
  description = " The name of the resource group in which to create the Azure-SSIS Integration Runtime. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = ""
}