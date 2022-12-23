variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "azuread_groups" {
  type        = any
  description = "Set of groups to be created."
}
variable "tenant_id" {
  type        = string
  description = "The tenant ID of the Azure AD environment where to create the groups."
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
