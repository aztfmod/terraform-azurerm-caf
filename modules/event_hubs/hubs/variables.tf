variable "global_settings" {}
variable "settings" {}
variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}
variable "base_tags" {}
variable "client_config" {}
variable "namespace_name" {
  description = "Name of the Event Hub Namespace."
  type        = string
}
variable "storage_account_id" {
  description = "Identifier of the storage account ID to be used."
  type        = string
}
