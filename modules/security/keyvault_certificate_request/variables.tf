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
  description = "Client Config"
  type        = map(any)
}
variable "tags" {
  default     = {}
  description = "Tags injected from the root module."
  nullable    = false
}
variable "inherit_tags" {
  type = bool
}
variable "cert_secret_name" {}
