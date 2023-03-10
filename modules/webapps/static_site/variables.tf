variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "tags" {
  description = "(Required) map of tags for the deployment"
}

variable "name" {
  description = "(Required) Name of the Static Site"
}

variable "location" {
  description = "(Required) Resource Location"
}

variable "resource_group_name" {
  description = "(Required) Resource group of the Static Site"
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
  default = null
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "diagnostic_profiles" {
  default = {}
}

variable "diagnostics" {
  default = null
}

variable "custom_domains" {
  default = {}
}
