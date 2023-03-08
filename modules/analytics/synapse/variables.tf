variable "settings" {
  description = "Configuration object for the Synapse workspace."
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "storage_data_lake_gen2_filesystem_id" {
  description = "The ID of the Datalake filesystem to be used by Synapse."
}

variable "resource_group" {
  description = "Resource group object"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}

variable "keyvault_id" {
  description = "The ID of the Key Vault to be used by the Synapse workspace."
  type        = string
  default     = null
}

variable "vnets" {
  default = {}
}
variable "private_endpoints" {
  default = {}
}
variable "private_dns" {
  default = {}
}
