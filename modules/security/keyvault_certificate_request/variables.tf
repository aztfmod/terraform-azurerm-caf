variable "certificate_issuers" {
  default = {}
}
variable "keyvault_id" {
  type = string
}
variable "settings" {
  type = any
}
variable "domain_name_registrations" {
  default = {}
}
variable "client_config" {
  type        = map(any)
  description = "Client Config"
}
