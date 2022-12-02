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
variable "application_id" {
  type        = any
  description = "Application ID of the service principal to create."
}
variable "azuread_api_permissions" {
  type    = any
  default = {}
}
variable "user_type" {
  type = any
}
