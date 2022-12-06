variable "scope" {
  type = any
}
variable "role_definition_name" {
  type    = any
  default = null
}
variable "role_definition_id" {
  type    = any
  default = null
}
variable "keys" {
  type = any
}
variable "azuread_apps" {
  type = any
}
variable "azuread_groups" {
  type = any
}
variable "managed_identities" {
  type = any
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}