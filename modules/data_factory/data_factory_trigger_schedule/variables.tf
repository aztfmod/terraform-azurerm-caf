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
  description = "Used for general parameter."
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Data Factory Schedule Trigger"
}
variable "data_factory_id" {
  type        = string
  description = "(Required) The Data Factory ID in which to associate the Schedule Trigger with"
}
variable "pipeline_name" {
  type        = any
  description = "(Required) The Data Factory Pipeline name that the trigger will act on"
}
