variable "scope" {
  type = any
}
variable "mode" {
  type = any
}
variable "role_mappings" {
  type = any
}
variable "custom_roles" {
  type    = any
  default = {}
}
variable "azuread_apps" {
  type    = any
  default = {}
}
variable "azuread_groups" {
  type    = any
  default = {}
}
variable "managed_identities" {
  type    = any
  default = {}
}
variable "object_id" {
  type    = any
  default = {}
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
