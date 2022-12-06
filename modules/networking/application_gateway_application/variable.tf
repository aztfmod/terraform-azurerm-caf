variable "settings" {
  type = any
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "application_gateway" {
  type = any
}
variable "app_services" {
  type    = any
  default = {}
}
variable "keyvaults" {
  type    = any
  default = {}
}
variable "keyvault_certificates" {
  type    = any
  default = {}
}
variable "keyvault_certificate_requests" {
  type    = any
  default = {}
}
variable "application_gateway_waf_policies" {
  type    = any
  default = {}
}
