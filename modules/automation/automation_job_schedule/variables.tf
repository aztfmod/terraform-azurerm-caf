variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}

variable "automation_account_name" {
  description = "(Required) Name of the related automation account"
  type        = string
}

variable "schedule_name" {
  description = "(Required) Schedule name"
  type        = string
}

variable "settings" {
  description = "Automation job schedule settings"
}

variable "runbook_name" {
  description = "(Required) Type of the runbook"
  type        = string
}