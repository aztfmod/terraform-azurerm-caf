variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "settings" {
  type = any
}
variable "resource_group" {
  type = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "storage_accounts" {
  type    = any
  default = {}
}