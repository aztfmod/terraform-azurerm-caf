variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type        = any
  description = "Used for general parameter."
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Data Factory Dataset"
}

variable "data_factory_id" {
  description = "(Required) The Data Factory name in which to associate the Dataset with"
}

variable "linked_service_name" {
  description = "(Required) The Data Factory Linked Service name in which to associate the Dataset with"
}