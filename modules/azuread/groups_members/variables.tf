variable "settings" {
  type = any
}
variable "group_id" {
  type    = any
  default = null
}
variable "client_config" {
  type = any
}
variable "group_key" {
  type    = any
  default = null
}
variable "azuread_groups" {
  type    = any
  default = {}
}
variable "azuread_apps" {
  type    = any
  default = {}
}
variable "azuread_service_principals" {
  type    = any
  default = {}
}
variable "managed_identities" {
  type    = any
  default = {}
}
variable "mssql_servers" {
  type    = any
  default = {}
}
