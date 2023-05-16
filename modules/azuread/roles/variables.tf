variable "object_id" {
  type = any
}
variable "azuread_roles" {
  type = any
}
variable "settings" {
  description = "Set the version to 'v1' to use the latest version of the AzureAD provider."
  default     = {}
}
