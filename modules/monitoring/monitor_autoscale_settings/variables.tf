variable "global_settings" {}
variable "resource_group_name" {}
variable "location" {}
variable "target_resource_id" {}
variable "virtual_machine_scale_sets" {
  default = {}
}
variable "settings" {
  default     = {}
  description = "Configuration object for the monitor autoscale setting resource"
}
