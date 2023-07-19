variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}

variable "tags" {
  type        = any
  description = "(Required) map of tags for the deployment"
}

variable "name" {
  type        = string
  description = "(Required) Name of the Static Site"
}

variable "location" {
  type        = string
  description = "(Required) Resource Location"
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

variable "sku_tier" {
  description = "Specifies the SKU tier of the Static Web App. Possible values are Free or Standard. Defaults to Free."
  type        = string
  default     = null

  validation {
    condition     = contains(["Free", "Standard"], var.sku_tier)
    error_message = "Allowed values are Free or Standard."
  }
}

variable "sku_size" {
  description = "Specifies the SKU size of the Static Web App. Possible values are Free or Standard. Defaults to Free."
  type        = string
  default     = null

  validation {
    condition     = contains(["Free", "Standard"], var.sku_size)
    error_message = "Allowed values are Free or Standard."
  }
}

variable "identity" {
  type    = any
  default = null
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}

variable "diagnostic_profiles" {
  type    = any
  default = {}
}

variable "diagnostics" {
  type    = any
  default = null
}

variable "private_endpoints" {
  type    = any
  default = {}
}

variable "private_dns" {
  type    = any
  default = {}
}

variable "subnet_id" {
  type    = string
  default = ""
}

variable "vnets" {
  type = any
}
variable "custom_domains" {
  type    = any
  default = {}
}
