variable "virtual_machine_id" {
  type = any
}
variable "extension" {
  type = any
}
variable "extension_name" {
  type = any
}
variable "settings" {
  type    = any
  default = {}
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "keyvault_id" {
  type    = string
  default = null
}
variable "keyvaults" {
  type    = any
  default = {}
}
variable "wvd_host_pools" {
  type    = any
  default = {}
}
variable "managed_identities" {
  type    = any
  default = {}
}
variable "storage_accounts" {
  type    = any
  default = {}
}
variable "virtual_machine_os_type" {
  type    = any
  default = {}
}
