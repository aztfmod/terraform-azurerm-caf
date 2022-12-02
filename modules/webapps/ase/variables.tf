variable "tags" {
  type        = any
  description = "(Required) map of tags for the deployment"
}

variable "name" {
  type        = string
  description = "(Required) Name of the App Service Environment"
}

variable "kind" {
  type        = any
  description = "(Required) Kind of resource. Possible value are ASEV2"
}

variable "zone" {
  type        = any
  description = "(Required) Availability Zone of resource. Possible value are 1, 2 or 3"
}

variable "location" {
  type        = string
  description = "(Required) Resource Location"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group of the ASE"
}

variable "subnet_id" {
  type        = string
  description = "(Required) Name of the Virtual Network for the ASE"
}

variable "subnet_name" {
  type = any
}

variable "internalLoadBalancingMode" {
  type = any
}

variable "diagnostics" {
  type    = any
  default = null
}

variable "diagnostic_profiles" {
  type    = any
  default = {}
}

variable "front_end_size" {
  type        = string
  description = "Instance size for the front-end pool."
  default     = "Standard_D1_V2"

  validation {
    condition     = contains(["Medium", "Large", "ExtraLarge", "Standard_D2", "Standard_D3", "Standard_D4", "Standard_D1_V2", "Standard_D2_V2", "Standard_D3_V2", "Standard_D4_V2"], var.front_end_size)
    error_message = "Only Medium, Large or ExtraLarge is supported."
  }
}

variable "front_end_count" {
  type        = string
  description = "Number of instances in the front-end pool.  Minimum of two."
  default     = "2"
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "private_dns" {
  type    = any
  default = {}
}

variable "settings" {
  type = any
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}