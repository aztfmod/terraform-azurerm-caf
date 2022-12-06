variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "name" {
  type        = string
  description = "(Required) Name of the Azure Firewall to be created"
}

variable "location" {
  type        = string
  description = "(Required) Location of the Azure Firewall to be created"
}

variable "tags" {
  type        = any
  description = "(Required) Tags of the Azure Firewall to be created"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource Group of the Azure Firewall to be created"
}

variable "subnet_id" {
  type        = string
  description = "(Required) ID for the subnet where to deploy the Azure Firewall"
  default     = null
}

variable "public_ip_id" {
  type        = any
  description = "(Optional) Public IP address identifier. IP address must be of type static and standard."
  default     = null
}

variable "diagnostics" {
  type    = any
  default = {}
}
variable "settings" {
  type = any
}

variable "diagnostic_profiles" {
  type    = any
  default = {}
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "public_ip_addresses" {
  type = any

}

variable "public_ip_keys" {
  type    = any
  default = {}
}

variable "virtual_wans" {
  type    = any
  default = {}
}

variable "virtual_hubs" {
  type    = any
  default = {}
}

variable "virtual_networks" {
  type = any

}

variable "client_config" {
  type    = any
  default = {}
}

variable "firewall_policy_id" {
  type    = any
  default = null
}