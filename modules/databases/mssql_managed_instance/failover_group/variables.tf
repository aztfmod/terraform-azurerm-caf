variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "settings" {
  type = any
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "primaryManagedInstanceId" {
  type = any
}
variable "partnerManagedInstanceId" {
  type = any
}
variable "partnerRegion" {
  type = any
}