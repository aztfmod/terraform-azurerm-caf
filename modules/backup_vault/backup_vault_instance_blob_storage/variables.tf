variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}
variable "settings" {
  type = any
}
variable "vault_id" {
  type = any
}
variable "storage_account_id" {
  type        = string
  description = "Identifier of the storage account ID to be used."
}
variable "backup_policy_id" {
  description = "The ID of the backup vault policy to be applied."
  type        = string
}
