variable "tags" {
  description = "(Required) Map of tags to be applied to the resource"
  type        = map(any)
}

variable "redis" {}

variable "subnet_id" {
  description = "The ID of the Subnet within which the Redis Cache should be deployed"
  type        = string
  default     = null
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "diagnostic_profiles" {
  default = {}
}
variable "diagnostics" {
  default = null
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
variable "client_config" {
  description = "Client configuration object (see module README.md)."
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
variable "managed_identities" {
  default = {}
}