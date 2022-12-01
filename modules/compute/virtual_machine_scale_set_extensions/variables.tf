variable "virtual_machine_scale_set_id" {}
variable "extension" {}
variable "extension_name" {}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "managed_identities" {
  type    = map(any)
  default = {}
}
variable "storage_accounts" {
  default = {}
}
variable "keyvault_id" {
  default = null
}
variable "keyvaults" {
  default = {}
}
variable "virtual_machine_scale_set_os_type" {
  default = {}
}
variable "log_analytics_workspaces" {
  default = {}
}
variable "remote_objects" {
  type    = map(any)
  default = {}
}