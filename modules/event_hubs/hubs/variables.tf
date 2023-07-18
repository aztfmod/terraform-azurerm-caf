variable "global_settings" {
  type = any
}
variable "settings" {
  type = any
}
variable "client_config" {
  type = any
}
variable "resource_group_name" {
  description = "Resource group name."
  default     = null
}
variable "namespace_name" {
  description = "Name of the Event Hub Namespace."
  type        = string
}
variable "storage_account_id" {
  type        = string
  description = "Identifier of the storage account ID to be used."
}
