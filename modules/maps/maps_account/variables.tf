variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "resource_group" {
  default = {}
}
variable "resource_group_name" {
  type = string
}
variable "settings" {}

variable "remote_objects" {
  default = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "client_config" {
  description = "Client configuration object."
  default     = {}
}