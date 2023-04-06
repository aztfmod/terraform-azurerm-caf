variable "managed_instance_id" {}
variable "key_vault_key_id" {
  description = "(Optional) To use customer managed keys from Azure Key Vault, provide the AKV Key ID. To use service managed keys, omit this field."
  default     = null
}