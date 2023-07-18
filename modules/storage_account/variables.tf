variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "storage_account" {
  type        = any
  description = "Storage account configuration object"
}
variable "resource_group_name" {
  type        = string
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  type        = any
  description = "Resource group object"
}
variable "location" {
  type        = string
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "vnets" {
  type    = any
  default = {}
}
variable "private_endpoints" {
  type    = any
  default = {}
}
variable "recovery_vaults" {
  type    = any
  default = {}
}
variable "private_dns" {
  type    = any
  default = {}
}

variable "diagnostic_profiles" {
  type    = any
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
  type    = any
  default = {}
}

variable "managed_identities" {
  type    = any
  default = {}
}

variable "var_folder_path" {}

variable "virtual_subnets" {
  description = "Map of virtual_subnets objects"
  default     = {}
  nullable    = false
}
