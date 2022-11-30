variable "certificate_issuers" {
  default = {}
}
variable "keyvault_id" {}
variable "settings" {
  type = any
}
variable "domain_name_registrations" {
  default = {}
}
variable "client_config" {
  description = "Client Config"
  type        = map(any)
}