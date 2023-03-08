variable "diagnostics" {}
variable "client_config" {}
variable "global_settings" {}
variable "settings" {}
variable "resource_group" {
  description = "Resource group object"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}