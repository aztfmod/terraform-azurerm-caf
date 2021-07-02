variable "group_object_id" {}
variable "member_object_id" {
  default = null
}
variable "azuread_service_principals" {
  default = {}
}
variable "members" {
  default = {}
}