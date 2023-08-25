variable "settings" {
  default = {}
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "azuread_applications" {
  default = {}
}
variable "oidc_issuer_url" {
  default = null
}