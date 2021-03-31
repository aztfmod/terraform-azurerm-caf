variable "policy_settings" {
  description = "(Required) Azure Firewall Policy Configuration"
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the Resource Group in which the Firewall exists. Changing this forces a new resource to be created."
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource"
  default     = {}
}

variable "base_tags" {}


variable "name" {
}
