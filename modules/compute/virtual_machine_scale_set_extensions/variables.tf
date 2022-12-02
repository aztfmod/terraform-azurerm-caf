variable "virtual_machine_scale_set_id" {
  type = any
}
variable "extension" {
  type = any
}
variable "extension_name" {
  type = any
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "managed_identities" {
  type    = any
  default = {}
}
variable "storage_accounts" {
  type    = any
  default = {}
}
variable "keyvault_id" {
  type    = string
  default = null
}
variable "keyvaults" {
  type    = any
  default = {}
}
variable "virtual_machine_scale_set_os_type" {
  type    = any
  default = {}
}
variable "log_analytics_workspaces" {
  type    = any
  default = {}
}
variable "remote_objects" {
  type    = any
  default = {}
}