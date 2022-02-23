variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "mi_name" {}
variable "settings" {}
variable "user_principal_name" {
  default = null
}
variable "group_name" {
  default = null
}
variable "group_id" {
  default = null
}