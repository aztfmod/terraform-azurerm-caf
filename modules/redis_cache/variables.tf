variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = any
  description = "(Required) Map of tags to be applied to the resource"
}

variable "redis" {
  type = any
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet within which the Redis Cache should be deployed"
  default     = null
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}

variable "diagnostic_profiles" {
  type    = any
  default = {}
}
variable "diagnostics" {
  type    = any
  default = null
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
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
