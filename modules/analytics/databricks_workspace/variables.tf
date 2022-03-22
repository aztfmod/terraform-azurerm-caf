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

# variable "location" {
#   description = "Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
#   type        = string
# }

variable "resource_group_name" {
  description = "The resource group object where to create the resource."
}

variable "location" {
  description = "The location where to create the resource."
}

variable "vnets" {
  description = "Virtual networks objects - contains all virtual networks that could potentially be used by the module."
}

variable "aml" {
  description = "Azure Machine Learning objects - contains all AML workspaces that could potentially be used by the module."
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "diagnostics" {
  description = "(Required) Diagnostics object with the definitions and destination services"
}