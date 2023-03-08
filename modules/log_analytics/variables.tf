variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "log_analytics" {
  description = "Log analytics configuration object"
}
variable "resource_group" {
  description = "Resource group object"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}