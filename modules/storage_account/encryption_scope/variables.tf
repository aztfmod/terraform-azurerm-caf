variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}

variable "settings" {
  type        = any
  description = "Storage account object."
}

variable "storage_account_id" {
  type        = string
  description = "Storage account resource id to attach the encryption scopes to."
}

variable "keyvault_keys" {
  type        = any
  description = "combined_objects_keyvault_keys"
  default     = {}
}