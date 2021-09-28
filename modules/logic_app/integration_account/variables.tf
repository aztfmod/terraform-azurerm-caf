variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  description = "Settings object (see module README.md)."
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "tags" {
  description = "(Required) map of tags for the deployment"
  default     = null
}
variable "location" {
  description = "(Required) Resource Location"
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "(Required) Resource group of the Logic App"
}