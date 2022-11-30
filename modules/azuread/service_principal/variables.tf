variable "global_settings" {
  type    = any
  default = {}
}
variable "settings" {
  type    = any
  default = {}
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "application_id" {
  description = "Application ID of the service principal to create."
}
variable "azuread_api_permissions" {
  default = {}
}
variable "user_type" {}
