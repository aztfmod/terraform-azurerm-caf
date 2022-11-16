variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "settings" {
  description = "Settings configuration object (see module README.md)."
}

variable "key_vault_id" {
  description = "(Required) The ID of the Key Vault. Changing this forces a new resource to be created."
}
variable "key_name" {
  description = "(Required) The name of Key Vault Key."
}
variable "key_version" {
  description = "(Required) The version of Key Vault Key."
}
variable "user_identity" {
  description = "(Optional) The user assigned identity that has access to the Key Vault Key. If not specified, system assigned identity will be used."
}