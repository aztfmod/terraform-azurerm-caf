variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type = any
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "primary_server_name" {}
variable "secondary_server_id" {}
variable "databases" {}