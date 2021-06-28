variable "settings" {}
variable "group_id" {}
variable "client_config" {}
variable "azuread_groups" {
  default = {}
}
variable "azuread_apps" {
  default = {}
}
variable "azuread_service_principals" {
  default = {}
}