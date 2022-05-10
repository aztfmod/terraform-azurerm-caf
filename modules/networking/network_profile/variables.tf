variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {}
variable "resource_group" {}
variable "remote_objects" {}
variable "base_tags" {
  default = {}
}