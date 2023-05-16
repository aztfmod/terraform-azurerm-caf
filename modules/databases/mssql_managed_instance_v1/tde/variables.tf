variable "managed_instance_id" {}
variable "key_vault_key_id" {
  description = "(Optional) To use customer managed keys from Azure Key Vault, provide the AKV Key ID. To use service managed keys, omit this field."
  default     = null
}
variable "auto_rotation_enabled" {
  description = " (Optional) When enabled, the SQL Managed Instance will continuously check the key vault for any new versions of the key being used as the TDE protector. If a new version of the key is detected, the TDE protector on the SQL Managed Instance will be automatically rotated to the latest key version within 60 minutes."
  default     = null
}