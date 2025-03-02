# This file contains the input variables for the cognitive_account_customer_managed_key module.
variable "cognitive_account_id" {
  description = "The ID of the Cognitive Service Account."
  type        = string
}

variable "key_vault_key_id" {
  description = "The ID of the Key Vault Key."
  type        = string
}

variable "identity_client_id" {
  description = "The Client ID of the Managed Identity."
  type        = string
}