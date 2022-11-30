variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "mi_name" {}
variable "settings" {
  type = any
}
variable "user_principal_name" {
  default = null
}
variable "group_name" {
  default = null
}
variable "group_id" {
  default = null
}