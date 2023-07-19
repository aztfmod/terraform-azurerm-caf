variable "settings" {
  type        = any
  description = "Configuration object for the Databricks workspace."
  # # optional fields supported after TF14
  # type = object({
  #   name                        = string
  #   resource_group_key          = string
  #   sku                         = optional(string)
  #   managed_resource_group_name = optional(string)
  #   tags                        = optional(map(string))
  #   custom_parameters = object({
  #     no_public_ip       = bool
  #     public_subnet_key  = string
  #     private_subnet_key = string
  #     vnet_key           = string
  #   })
  # })
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}

variable "vnets" {
  type        = any
  description = "Virtual networks objects - contains all virtual networks that could potentially be used by the module."
}

variable "aml" {
  type        = any
  description = "Azure Machine Learning objects - contains all AML workspaces that could potentially be used by the module."
}

variable "diagnostics" {
  type        = any
  description = "(Required) Diagnostics object with the definitions and destination services"
}

variable "private_endpoints" {
  type    = any
  default = {}
}

variable "resource_groups" {
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
