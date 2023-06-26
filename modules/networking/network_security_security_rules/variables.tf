variable "settings" {
  description = "(Required) configuration object describing the networking configuration, as described in README"
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "client_config" {
  description = "client_config object (see module README.md)"
}

variable "remote_objects" {
  default = {}
}

variable "direction" {}