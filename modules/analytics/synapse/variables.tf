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

variable "keyvault_id" {
  type        = string
  description = "The ID of the Key Vault to be used by the Synapse workspace."
  default     = null
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
variable "location" {
  type        = string
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  type        = any
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
