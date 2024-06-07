variable "global_settings" {
  description = "global settings"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {}
variable "route_servers" {}
variable "remote_objects" {
  default     = {}
}
