variable "settings" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "diagnostics" {}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "public_ip_addresses" {
  default = {}
}
variable "vnets" {
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
  type        = map(any)
}
variable "private_dns" {
  default = {}
}
variable "managed_identities" {
  default = {}
}
variable "application_gateway_waf_policies" {
  default = {}
}
variable "keyvaults" {
  default = {}
}