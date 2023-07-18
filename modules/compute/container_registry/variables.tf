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

variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Container Registry. Changing this forces a new resource to be created."
}

variable "admin_enabled" {
  type        = bool
  description = "(Optional) Specifies whether the admin user is enabled. Defaults to false."
  default     = false
}

variable "sku" {
  type        = string
  description = "(Optional) The SKU name of the container registry. Possible values are Basic, Standard and Premium. Defaults to Basic"
  default     = "Basic"
}

variable "tags" {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}

variable "georeplications" {
  type        = any
  description = "(Optional) Updated structure for Azure locations where the container registry should be geo-replicated."
  default     = {}
}

variable "vnets" {
  type    = any
  default = {}
}

variable "network_rule_set" {
  type        = any
  description = " (Optional) A network_rule_set block as documented https://www.terraform.io/docs/providers/azurerm/r/container_registry.html"
  default     = {}
}

variable "diagnostic_profiles" {
  type    = any
  default = {}
}

variable "diagnostics" {
  type    = any
  default = {}
}

variable "private_endpoints" {
  type    = any
  default = {}
}

variable "private_dns" {
  type    = any
  default = {}
}

variable "public_network_access_enabled" {
  type    = any
  default = "true"
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

variable "retention_policy" {
  type = object({
    days = optional(number, 0)
  })
  description = "(Optional) Structure describing untagged container retention policy"
  default     = null
}
