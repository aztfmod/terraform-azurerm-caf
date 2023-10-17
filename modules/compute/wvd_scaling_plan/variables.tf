variable "base_tags" { type = bool }
variable "diagnostic_profiles" { default = {} }
variable "diagnostics" {}
variable "global_settings" {}
variable "location" { default = null }
variable "host_pools" {}
variable "name" { default = {} }
variable "resource_group_name" { default = null }
variable "resource_group" {}
variable "settings" {}
variable "wvd_scaling_plans" { default = {} }