
variable "resource_id" {
  type        = any
  description = "(Required) Fully qualified Azure resource identifier for which you enable diagnostics."
}

variable "resource_location" {
  type        = any
  description = "(Required) location of the resource"
}

variable "client_config" {
  type        = any
  description = "client_config object (see module README.md)"
}

variable "diagnostics" {
  type        = any
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
  type    = any
  default = {}
}