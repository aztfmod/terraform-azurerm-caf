variable "settings" {}
variable "storage_account_id" {}
variable "local_users" {
  default = {}
}
variable "keyvault" {
  default = {}
}
variable "client_config" {
  description = "Client configuration object"
}
variable "remote_objects" {
  default = {}
}
variable "storage_accounts" {
  default = {}
}