variable "settings" {
  description = "(Required) Azure Firewall Policy Configuration"
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource"
  default     = {}
}

variable "resource_group" {
  description = "(Required) A resource_group object."
}

variable "base_policy_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the base Firewall Policy."
}
