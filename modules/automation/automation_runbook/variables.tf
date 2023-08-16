variable "automation_account_name" {}

variable "settings" {
  description = "Configuration object for the Automation account schedule."
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "location" {
  description = "(Optional) Resource Location"
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
  description = "Enable tags inheritence."
  type        = bool
}

variable "client_config" {}
