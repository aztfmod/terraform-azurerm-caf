variable "virtual_machine_id" {}
variable "extension" {}
variable "extension_name" {}
variable "settings" {
  type    = any
  default = {}
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "keyvault_id" {
  default = null
}
variable "keyvaults" {
  default = {}
}
variable "wvd_host_pools" {
  default = {}
}
variable "managed_identities" {
  default = {}
}
variable "storage_accounts" {
  default = {}
}
variable "virtual_machine_os_type" {
  default = {}
}