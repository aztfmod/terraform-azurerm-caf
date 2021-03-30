variable "scope" {}
variable "mode" {}
variable "role_mappings" {}
variable "custom_roles" {
  default = {}
}
variable "azuread_apps" {
  default = {}
}
variable "azuread_groups" {
  default = {}
}
variable "managed_identities" {
  default = {}
}
variable "object_id" {
  default = {}
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}