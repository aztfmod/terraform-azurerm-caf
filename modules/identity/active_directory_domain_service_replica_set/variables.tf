variable "settings" {
  description = "(Required) Used to handle passthrough paramenters."
}
variable "remote_objects" {
  description = "The remote objects the module depends on."
}
variable "location" {
  description = "Region of the the Replica Set."
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}