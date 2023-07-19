variable "resource_group_name" {
  type        = string
  description = "Resource group object to deploy the virtual machine"
  default     = null
}

variable "location" {
  type        = string
  description = "(Optional) Resource Location"
  default     = null
}
variable "resource_group" {
  type        = any
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Enable tags inheritence."
  type        = bool
}
variable "settings" {
  type = any
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
