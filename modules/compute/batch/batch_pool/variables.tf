variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {}
variable "batch_account" {}
variable "managed_identities" {
  default = {}
}
variable "batch_certificates" {
  default = {}
}
variable "vnets" {
  default = {}
}
