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
variable "resource_group" {
  type = any
}
variable "remote_objects" {
  type = any
}
variable "base_tags" {
  type    = map(any)
  default = {}
}