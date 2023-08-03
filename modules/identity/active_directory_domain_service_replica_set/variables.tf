variable "settings" {
  description = "(Required) Used to handle passthrough paramenters."
}
variable "remote_objects" {
  description = "The remote objects the module depends on."
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  description = "Location of the replica set"
}