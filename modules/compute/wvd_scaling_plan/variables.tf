variable "base_tags" { type = bool }
variable "diagnostic_profiles" { default = {} }
variable "diagnostics" {}
variable "global_settings" {}
variable "location" { default = null }
variable "name" { default = {} }
variable "resource_group_name" { default = null }
variable "resource_group" {}
variable "settings" {}
variable "wvd_scaling_plans" { default = {} }