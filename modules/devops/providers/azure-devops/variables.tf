variable "project" {
  description = "The object representative of the ado project entity to update."
  type        = map(any)
}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}