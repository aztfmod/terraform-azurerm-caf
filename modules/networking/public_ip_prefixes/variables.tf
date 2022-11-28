variable "name" {
  description = "(Required) Specifies the name of the Public IP Prefix resource . Changing this forces a new resource to be created."
  type        = string
}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "sku" {
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  type        = string
  default     = "Basic"
  validation {
    condition     = contains(["Basic", "Standard"], var.sku)
    error_message = "Provide an allowed value as defined in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip#sku."
  }
}

variable "prefix_length" {
  description = "(Optional) Specifies the number of bits of the prefix. The value can be set between 0 (4,294,967,296 addresses) and 31 (2 addresses). Defaults to 28(16 addresses). Changing this forces a new resource to be created."
  type        = string
  default     = 28

  validation {
    condition     = alltrue([var.prefix_length >= 0, var.prefix_length <= 31])
    error_message = "Provide an allowed value as defined in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip_prefix#prefix_length."
  }
}

variable "ip_version" {
  description = "(Optional) The IP Version to use, IPv6 or IPv4."
  type        = string
  default     = "IPv4"

  validation {
    condition     = contains(["IPv4", "IPv6"], var.ip_version)
    error_message = "Provide an allowed value as defined in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip#ip_version."
  }
}

variable "tags" {
  description = "(Optional) Tags for the resource to be deployed."
  default     = null
  type        = map(any)
}

variable "create_pips" {
  description = "(Optional) When true all IP's will be created and provided as output."
  default     = false
  type        = bool
}

variable "pip_settings" {
  description = "(Optional) PIP settings when create_ips = true."
  default     = {}
}

variable "zones" {
  description = "(Optional) The availability zone to allocate the Public IP in. Possible values are Zone-Redundant, 1, 2, 3, and No-Zone. Defaults to Zone-Redundant."
  type        = string
  default     = "Zone-Redundant"

  validation {
    condition     = contains(["Zone-Redundant", "No-Zone", "1", "2", "3"], var.zones)
    error_message = "Provide an allowed value as defined in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip#availability_zone."
  }
}

variable "diagnostics" {
  description = "(Optional) Diagnostics objects where to deploy the diagnostics profiles."
  default     = {}
}

variable "diagnostic_profiles" {
  description = "(Optional) Diagnostics profile settings to be deployed for the resource."
  default     = {}
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}