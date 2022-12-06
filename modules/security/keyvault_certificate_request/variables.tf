variable "certificate_issuers" {
  type    = any
  default = {}
}
variable "keyvault_id" {
  type = string
}
variable "settings" {
  type = any
}
variable "domain_name_registrations" {
  type    = any
  default = {}
}
variable "client_config" {
  type        = any
  description = "Client Config"
}
