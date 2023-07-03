variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "storage_account" {
  description = "Storage account configuration object"
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
variable "vnets" {
  default = {}
}
variable "private_endpoints" {
  default = {}
}
variable "recovery_vaults" {
  default = {}
}
variable "private_dns" {
  default = {}
}

variable "diagnostic_profiles" {
  default = {}
}

variable "diagnostic_profiles_blob" {
  default = {}
}

variable "diagnostic_profiles_queue" {
  default = {}
}

variable "diagnostic_profiles_table" {
  default = {}
}

variable "diagnostic_profiles_file" {
  default = {}
}

variable "diagnostics" {
  default = {}
}

variable "managed_identities" {
  default = {}
}

variable "var_folder_path" {}

variable "virtual_subnets" {
  description = "Map of virtual_subnets objects"
  default     = {}
  nullable    = false
}