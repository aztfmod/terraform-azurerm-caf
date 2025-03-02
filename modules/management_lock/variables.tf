variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "client_config" {
  description = "Client configuration object."
  default     = {}
}

variable "remote_objects" {
  default = {}
}
variable "name" {}
variable "resource_type" {
  default = ""
}
variable "resource_lz_key" {
  default = ""
}
variable "resource_key" {
  default = ""
}
variable "resource_id" {
  default = ""
}
variable "lock_level" {}
variable "notes" {
  default = null
}
