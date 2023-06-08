variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "automation_account_name" {}

variable "settings" {
  description = "Configuration object for the Automation account schedule."
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "client_config" {}
