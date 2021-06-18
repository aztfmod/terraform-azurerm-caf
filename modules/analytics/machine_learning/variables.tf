variable "settings" {
  description = "Configuration object for the machine learning workspace."
  # # optional fields supported after TF14
  # type = object({
  #   name                    = string
  #   resource_group_key      = string
  #   application_insights_id = string
  #   key_vault_id            = optional(string)
  #   storage_account_id      = optional(string)
  #   tags                    = optional(map(string))
  #   sku_name                = string
  #   #identity {}
  # })
}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}

variable "keyvault_id" {
  description = "The ID of the Key Vault to be used by the machine learning workspace."
  type        = string
}

variable "storage_account_id" {
  description = "The ID of the Storage Account to be used by the nachine learning workspace."
  type        = string
}
variable "application_insights_id" {
  description = "The ID of the App Insights to be used by the nachine learning workspace."
  type        = string
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "vnets" {
  description = "Virtual networks objects - contains all virtual networks that could potentially be used by the module."
}

variable "container_registry_id" {
  default = ""
}