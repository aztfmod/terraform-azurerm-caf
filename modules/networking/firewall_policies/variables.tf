variable "settings" {
  type        = any
  description = "(Required) Azure Firewall Policy Configuration"
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}

variable "tags" {
  type        = any
  description = "(Optional) A mapping of tags to assign to the resource"
  default     = {}
}

variable "resource_group" {
  type        = any
  description = "(Required) A resource_group object."
}

variable "base_policy_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the base Firewall Policy."
}
