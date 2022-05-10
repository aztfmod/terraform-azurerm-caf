variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "log_analytics" {}
variable "resource_group_name" {}
variable "location" {}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}