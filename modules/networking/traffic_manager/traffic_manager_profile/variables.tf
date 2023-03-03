variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "settings" {
  default = {}
}
variable "resource_group" {
  description = "Resource group object"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}