variable "settings" {}
variable "global_settings" {}
variable "location" {
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "resource_group_name" {
  description = "Resource group object"
  default     = null
}
variable "base_tags" {
  type = bool
}

variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}

variable "remote_objects" {}

variable "client_config" {
  default = {}
}