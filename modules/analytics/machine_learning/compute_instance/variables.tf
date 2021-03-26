variable "settings" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "machine_learning_workspace_name" {}
variable "subnet_id" {}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "tags" {
  description = "(Required) Map of tags to be applied to the resource"
  type        = map(any)
}