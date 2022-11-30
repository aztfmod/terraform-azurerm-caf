variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type = any
}
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
