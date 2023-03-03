variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "resource_group" {
  description = "Resource group object"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "settings" {}
variable "keyvaults" {
  description = "Keyvault to store the nsxt_password and the vcenter_password"
  default     = {}
}
variable "dynamic_keyvault_secrets" {
  description = "Keyvault Secret to store the nsxt_password and the vcenter_password"
  default     = {}
}