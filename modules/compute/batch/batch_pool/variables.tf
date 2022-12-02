variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type = any
}
variable "batch_account" {
  type = any
}
variable "managed_identities" {
  type    = any
  default = {}
}
variable "batch_certificates" {
  type    = any
  default = {}
}
variable "vnets" {
  type    = any
  default = {}
}
