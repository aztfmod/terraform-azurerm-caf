variable "settings" {
  default = {}
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "resource_group" {
  default = {}
}
variable "managed_identities" {
  default = {}
}
variable "oidc_issuer_url" {
  default = null
}