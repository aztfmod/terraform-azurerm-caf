variable "global_settings" {
  type = any

}
variable "client_config" {
  type = map(any)
}
variable "resource_group_name" {}
variable "location" {}
variable "virtual_machine_scale_sets" {
  default = {}
}
variable "settings" {
  type        = any
  default     = {}
  description = "Configuration object for the monitor autoscale setting resource"
}
variable "remote_objects" {
  default = {}
}