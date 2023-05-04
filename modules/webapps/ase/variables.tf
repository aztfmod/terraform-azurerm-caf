variable "tags" {
  description = "(Required) map of tags for the deployment"
}

variable "name" {
  description = "(Required) Name of the App Service Environment"
}

variable "kind" {
  description = "(Required) Kind of resource. Possible value are ASEV2"
}

variable "zone" {
  description = "(Required) Availability Zone of resource. Possible value are 1, 2 or 3"
}

variable "location" {
  description = "(Required) Resource Location"
}

variable "resource_group_name" {
  description = "(Required) Resource group of the ASE"
}

variable "subnet_id" {
  description = "(Required) Name of the Virtual Network for the ASE"
}

variable "subnet_name" {}

variable "internalLoadBalancingMode" {}

variable "diagnostics" {
  default = null
}

variable "diagnostic_profiles" {
  default = {}
}

variable "front_end_size" {
  description = "Instance size for the front-end pool."
  default     = "Standard_D1_V2"

  validation {
    condition     = contains(["Medium", "Large", "ExtraLarge", "Standard_D2", "Standard_D3", "Standard_D4", "Standard_D1_V2", "Standard_D2_V2", "Standard_D3_V2", "Standard_D4_V2"], var.front_end_size)
    error_message = "Only Medium, Large or ExtraLarge is supported."
  }
}

variable "front_end_count" {
  description = "Number of instances in the front-end pool.  Minimum of two."
  default     = "2"
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "private_dns" {
  default = {}
}

variable "settings" {}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}