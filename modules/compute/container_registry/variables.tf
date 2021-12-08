variable "settings" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Container Registry. Changing this forces a new resource to be created."
}

variable "admin_enabled" {
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
  default     = false
}

variable "sku" {
  description = "(Optional) The SKU name of the container registry. Possible values are Basic, Standard and Premium. Defaults to Basic"
  default     = "Basic"
}

variable "tags" {
  type        = map(any)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

variable "georeplications" {
  description = "(Optional) Updated structure for Azure locations where the container registry should be geo-replicated."
  default     = {}
}

variable "vnets" {
  default = {}
}

variable "network_rule_set" {
  description = " (Optional) A network_rule_set block as documented https://www.terraform.io/docs/providers/azurerm/r/container_registry.html"
  default     = {}
}

variable "diagnostic_profiles" {
  default = {}
}

variable "diagnostics" {
  default = {}
}

variable "private_endpoints" {
  default = {}
}

variable "resource_groups" {
  default = {}
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "private_dns" {
  default = {}
}

variable "public_network_access_enabled" {
  default = "true"
}