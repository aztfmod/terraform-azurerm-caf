variable "name" {
  description = "(Required) Specifies the name of the Public IP resource . Changing this forces a new resource to be created."
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

variable "allocation_method" {
  description = "(Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic."
  type        = string
  default     = "Dynamic"

  validation {
    condition     = contains(["Dynamic", "Static"], var.allocation_method)
    error_message = "Provide an allowed value as defined in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip#allocation_method."
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

variable "idle_timeout_in_minutes" {
  description = "(Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  type        = number
  default     = null

  validation {
    condition     = (try(var.idle_timeout_in_minutes, false) == true ? (var.idle_timeout_in_minutes.value >= 4 || var.idle_timeout_in_minutes.value <= 30) : true)
    error_message = "Provide an allowed value as defined in https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip#idle_timeout_in_minutes."
  }
}

variable "domain_name_label" {
  description = "(Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
  default     = null
  type        = string
}

variable "generate_domain_name_label" {
  description = "Generate automatically the domain name label, if set to true, automatically generate a domain name label with the name"
  type        = bool
  default     = false
}

variable "reverse_fqdn" {
  description = "(Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN."
  type        = bool
  default     = null
}

variable "tags" {
  description = "(Optional) Tags for the resource to be deployed."
  default     = null
  type        = map(any)
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

variable "ip_tags" {
  description = "(Optional) A mapping of IP tags to assign to the public IP."
  default     = {}
  type        = map(any)
}

variable "public_ip_prefix_id" {
  description = "(Optional) If specified then public IP address allocated will be provided from the public IP prefix resource."
  default     = ""
  type        = string
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}