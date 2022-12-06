variable "global_settings" {
  type = any

}
variable "settings" {
  type = any
}
variable "resource_group" {
  type        = any
  description = "Resource group objects."
}
variable "base_tags" {
  type = map(any)
}
variable "client_config" {
  type = any
}
variable "namespace_name" {
  type        = any
  description = "Name of the Event Hub Namespace."
}
variable "storage_account_id" {
  type        = string
  description = "Identifier of the storage account ID to be used."
}
