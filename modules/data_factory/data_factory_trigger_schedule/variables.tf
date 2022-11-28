variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  description = "Used for general parameter."
}
variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Data Factory Schedule Trigger"
}
variable "data_factory_id" {
  description = "(Required) The Data Factory ID in which to associate the Schedule Trigger with"
}
variable "pipeline_name" {
  description = "(Required) The Data Factory Pipeline name that the trigger will act on"
}