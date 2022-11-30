
variable "resource_id" {
  description = "(Required) Fully qualified Azure resource identifier for which you enable diagnostics."
}

variable "resource_location" {
  description = "(Required) location of the resource"
}

variable "client_config" {
  type        = map(any)
  description = "client_config object (see module README.md)"
}

variable "diagnostics" {
  description = "(Required) Contains the diagnostics setting object."
}

variable "settings" {
  type    = any
  default = {}
}

variable "global_settings" {
  type    = any
  default = {}
}

variable "network_watchers" {
  default = {}
}