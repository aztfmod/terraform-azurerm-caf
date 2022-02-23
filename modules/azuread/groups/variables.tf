variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "azuread_groups" {
  description = "Set of groups to be created."
}
variable "tenant_id" {
  description = "The tenant ID of the Azure AD environment where to create the groups."
  type        = string
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}