variable "settings" {
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
  description = "Global settings object (see module README.md)"
}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "vnets" {
  description = "Virtual networks objects - contains all virtual networks that could potentially be used by the module."
}

variable "aml" {
  description = "Azure Machine Learning objects - contains all AML workspaces that could potentially be used by the module."
}

variable "diagnostics" {
  description = "(Required) Diagnostics object with the definitions and destination services"
}

variable "private_endpoints" {
  default = {}
}

variable "resource_groups" {
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