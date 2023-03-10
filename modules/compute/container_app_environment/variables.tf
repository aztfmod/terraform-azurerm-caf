variable "settings" {
  description = "(Required) Object describing container app environment.  Reference attribute descriptions here: https://learn.microsoft.com/en-us/azure/templates/microsoft.app/managedenvironments?pivots=deployment-language-terraform"
  type = object({
    name               = string
    region             = optional(string, null)
    resource_group_key = string
    sku                = optional(string, "Consumption")
    zone_redundant     = optional(bool, false)
    custom_domain_config = optional(object({
      dns_suffix = optional(string, null)
    }), null)
    log_analytics = optional(object({
      # key points to a log analytics workspace defined by launchpad
      destination_key = string
    }), null)
    vnet = optional(object({
      lz_key                   = optional(string)
      vnet_key                 = optional(string, null)
      subnet_key               = optional(string, null)
      docker_bridge_cidr       = optional(string, "10.1.0.1/16")
      internal                 = optional(bool, true)
      platform_reserved_cidr   = optional(string, "10.0.0.0/16")
      platform_reserved_dns_ip = optional(string, "10.0.0.2")
    }), null)

    tags = optional(map(any), {})
  })
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
  default     = {}
}

variable "resource_groups" {
  type        = any
  description = "(Required) Map of existing resource group objects."
}

variable "global_settings" {
  type        = any
  description = "Global settings object"
}

variable "diagnostics" {
  type        = any
  description = "(Required) Contains the diagnostics setting object."
}

variable "vnets" {
  type        = any
  description = "Combined map of vnets (used when container app environment needs to go into vnet)"
}

variable "client_config" {
  type        = any
  description = "Configuration object for client deploying landing zone"
}

variable "private_dns" {
  type        = any
  description = "Combined map of private DNS resources"
  default     = {}
}
