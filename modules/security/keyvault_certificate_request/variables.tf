variable "certificate_issuers" {
  default = {}
}
variable "keyvault_id" {}
variable "keyvault_uri" {}
variable "settings" {}
variable "domain_name_registrations" {
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