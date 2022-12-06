variable "global_settings" {
  type    = any
  default = {}
}
variable "settings" {
  type    = any
  default = {}
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "azuread_api_permissions" {
  type    = any
  default = {}
}
variable "user_type" {
  type = any
}
