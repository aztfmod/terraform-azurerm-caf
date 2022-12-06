variable "global_settings" {
  type = any

}
variable "client_config" {
  type = any
}
variable "settings" {
  type = any
}

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Data Factory Linked Service Key Vault. Changing this forces a new resource to be created. Must be globally unique."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Data Factory Linked Service Key Vault. Changing this forces a new resource."
}

variable "data_factory_id" {
  type        = string
  description = "(Required) The Data Factory ID in which to associate the Linked Service with. Changing this forces a new resource."
}

variable "description" {
  type        = any
  description = "(Optional) The description for the Data Factory Linked Service Key Vault."
  default     = null
}

variable "integration_runtime_name" {
  type        = any
  description = "(Optional) The integration runtime reference to associate with the Data Factory Linked Service Key Vault."
  default     = null
}

variable "annotations" {
  type        = any
  description = "(Optional) List of tags that can be used for describing the Data Factory Linked Service Key Vault."
  default     = null
}

variable "parameters" {
  type        = any
  description = "(Optional) A map of parameters to associate with the Data Factory Linked Service Key Vault."
  default     = null
}

variable "additional_properties" {
  type        = any
  description = "(Optional) A map of additional properties to associate with the Data Factory Linked Service Key Vault."
  default     = null
}

variable "key_vault_id" {
  type        = any
  description = "(Required) The ID the Azure Key Vault resource."
}