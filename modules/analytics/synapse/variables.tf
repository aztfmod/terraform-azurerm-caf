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
variable "location" {
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "resource_group_name" {
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}