variable "settings" {
  description = "Configuration object for the Synapse workspace."
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "storage_data_lake_gen2_filesystem_id" {
  description = "The ID of the Datalake filesystem to be used by Synapse."
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
  description = "The ID of the Key Vault to be used by the Synapse workspace."
  type        = string
  default     = null
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}