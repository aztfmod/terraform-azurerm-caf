variable "global_settings" {}
variable "client_config" {}
variable "resource_group_name" {}
variable "location" {}
variable "virtual_machine_scale_sets" {
  default = {}
}
variable "settings" {
  default     = {}
  description = "Configuration object for the monitor autoscale setting resource"
}
variable "remote_objects" {
  default = {}
}