variable "settings" {
  type        = any
  description = "Configuration object for the Synapse workspace."
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "storage_data_lake_gen2_filesystem_id" {
  type        = any
  description = "The ID of the Datalake filesystem to be used by Synapse."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}

variable "keyvault_id" {
  type        = string
  description = "The ID of the Key Vault to be used by the Synapse workspace."
  default     = null
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}
variable "vnets" {
  type    = any
  default = {}
}
variable "private_endpoints" {
  type    = any
  default = {}
}
variable "private_dns" {
  type    = any
  default = {}
}
