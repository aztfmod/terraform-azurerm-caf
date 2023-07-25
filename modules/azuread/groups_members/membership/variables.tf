variable "group_object_id" {}
variable "member_object_id" {
  default = null
}
variable "azuread_service_principals" {
  default = {}
}
variable "managed_identities" {
  default = {}
}
variable "members" {
  default = {}
}
variable "mssql_servers" {
  default = {}
}
variable "azuread_groups" {
  default     = {}
  description = "Support Azure AD group member of an Azure AD group."
}