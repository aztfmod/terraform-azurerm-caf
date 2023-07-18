variable "settings" {
  type = any
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "diagnostics" {
  type = any
}
variable "location" {
  description = "(Required) Resource Location"
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
variable "public_ip_addresses" {
  type    = any
  default = {}
}
variable "application_gateway_applications" {
  type = any
}
variable "app_services" {
  type    = any
  default = {}
}
variable "vnets" {
  type    = any
  default = {}
}

variable "sku_name" {
  type        = string
  default     = "Standard_v2"
  description = "(Optional) (Default = Standard_v2) The Name of the SKU to use for this Application Gateway. Possible values are Standard_Small, Standard_Medium, Standard_Large, Standard_v2, WAF_Medium, WAF_Large, and WAF_v2."

  validation {
    condition     = contains(["Standard_Small", "Standard_Medium", "Standard_Large", "Standard_v2", "WAF_Medium", "WAF_Large", "WAF_v2"], var.sku_name)
    error_message = "Provide an allowed value as defined in https://www.terraform.io/docs/providers/azurerm/r/application_gateway.html#sku."
  }
}

variable "sku_tier" {
  type        = string
  default     = "Standard_v2"
  description = "(Optional) (Default = Standard_v2) (Required) The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard_v2, WAF and WAF_v2."

  validation {
    condition     = contains(["Standard", "Standard_v2", "WAF", "WAF_v2"], var.sku_tier)
    error_message = "Provide an allowed value as defined in https://www.terraform.io/docs/providers/azurerm/r/application_gateway.html#sku."
  }
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "private_dns" {
  type    = any
  default = {}
}
variable "keyvault_certificates" {
  type    = any
  default = {}
}

variable "keyvault_certificate_requests" {
  type    = any
  default = {}
}
variable "managed_identities" {
  type    = any
  default = {}
}

variable "dns_zones" {
  type    = any
  default = {}
}

variable "keyvaults" {
  type    = any
  default = {}
}

variable "application_gateway_waf_policies" {
  type    = any
  default = {}
}
