variable "settings" {
  type = any
}
variable "resource_groups" {}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "diagnostics" {
  type = map(any)
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
# variable express_route_circuits {}
# variable express_route_authorizations {}
