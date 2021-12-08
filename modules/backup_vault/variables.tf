variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
  
#   validation {
#     condition     = contains(["southcentralus", "centralus"], var.location)
#     error_message = "Allowed values are southcentralus, centralus."
#   }
}
variable "settings" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
# variable "backup_vault" {}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "diagnostics" {}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "identity" {}
variable "storage_account_id" {
  description = "The ID of the Storage Account to be used by the Backup Vault instance."
  type        = string
}
