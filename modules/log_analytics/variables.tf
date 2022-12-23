variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "log_analytics" {
  type = any
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
