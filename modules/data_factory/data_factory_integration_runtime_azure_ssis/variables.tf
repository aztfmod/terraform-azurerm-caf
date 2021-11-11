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
variable "data_factory_name" {
  description = " Specifies the name of the Data Factory the Azure-SSIS Integration Runtime belongs to. Changing this forces a new resource to be created."
}
variable "resource_group_name" {
  description = " The name of the resource group in which to create the Azure-SSIS Integration Runtime. Changing this forces a new resource to be created."
}

variable "location" {
  description = ""
}