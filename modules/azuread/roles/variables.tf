variable "object_id" {}
variable "azuread_roles" {}
variable "settings" {
  description = "Set the version to 'v1' to use the latest version of the AzureAD provider."
  default     = {}
}