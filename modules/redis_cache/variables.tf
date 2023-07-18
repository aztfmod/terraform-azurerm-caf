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
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "redis_firewall_rules" {
  type = map(object({
    name     = optional(string)
    start_ip = string
    end_ip   = string
  }))
  default     = null
  description = "Map of firewall rules to associate with redis cache"
}
variable "managed_identities" {
  default = {}
}
