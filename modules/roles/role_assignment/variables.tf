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
  type    = map(any)
  default = {}
}
variable "object_id" {
  default = {}
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}