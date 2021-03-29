variable "scope" {}
variable "role_definition_name" {
  default = null
}
variable "role_definition_id" {
  default = null
}
variable "keys" {}
variable "azuread_apps" {}
variable "azuread_groups" {}
variable "managed_identities" {}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}