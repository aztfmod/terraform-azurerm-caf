variable "group_object_id" {
  type = any
}
variable "member_object_id" {
  type    = any
  default = null
}
variable "azuread_service_principals" {
  type    = any
  default = {}
}
variable "managed_identities" {
  type    = any
  default = {}
}
variable "members" {
  type    = any
  default = {}
}
variable "mssql_servers" {
  type    = any
  default = {}
}
