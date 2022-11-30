variable "settings" {
  type = any
}
variable "group_id" {
  default = null
}
variable "client_config" {
  type = map(any)
}
variable "group_key" {
  default = null
}
variable "azuread_groups" {
  default = {}
}
variable "azuread_apps" {
  default = {}
}
variable "azuread_service_principals" {
  default = {}
}
variable "managed_identities" {
  default = {}
}
variable "mssql_servers" {
  default = {}
}