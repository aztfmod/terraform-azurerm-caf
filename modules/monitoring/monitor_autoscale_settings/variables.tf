variable "global_settings" {
  type = any

}
variable "client_config" {
  type = any
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "virtual_machine_scale_sets" {
  type    = any
  default = {}
}
variable "settings" {
  type        = any
  default     = {}
  description = "Configuration object for the monitor autoscale setting resource"
}
variable "remote_objects" {
  type    = any
  default = {}
}