
variable "resource_id" {
  description = "(Required) Fully qualified Azure resource identifier for which you enable diagnostics."
}

variable "resource_location" {
  description = "(Required) location of the resource"
}

variable "client_config" {
  description = "client_config object (see module README.md)"
}

variable "diagnostics" {
  description = "(Required) Contains the diagnostics setting object."
}

variable "settings" {
  default = {}
}

variable "global_settings" {
  default = {}
}

variable "network_watchers" {
  default = {}
}