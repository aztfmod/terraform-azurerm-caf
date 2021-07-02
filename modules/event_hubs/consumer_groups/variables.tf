variable "global_settings" {}
variable "settings" {}
variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}
variable "client_config" {}
variable "namespace_name" {
  description = "Name of the Event Hub Namespace."
  type        = string
}
variable "eventhub_name" {
  description = "Name of the Event Hub."
  type        = string
}

