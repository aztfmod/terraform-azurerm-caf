variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "settings" {
  description = "Storage account object."
}

variable "storage_account_id" {
  description = "Storage account resource id to attach the encryption scopes to."
}

variable "keyvault_keys" {
  description = "combined_objects_keyvault_keys"
  default     = {}
}