variable "name" {}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "rule_name" {
  description = "(Required) The name of the route filter rule"
}

variable "rule_communities" {
  description = "(Required) The collection for bgp community values to filter on. e.g. ['12076:5010','12076:5020']."
  type        = list
}
variable "tags" {
  description = "(Required) Map of tags to be applied to the resource"
  type        = map(any)
}