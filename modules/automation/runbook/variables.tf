variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "settings" {
  description = "Configuration object for the Automation runbook."
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "runbook_type" {
  description = "(Required) Type of the runbook"
  type        = string

  validation {
    condition     = contains(["Graph", "GraphPowerShell", "GraphPowerShellWorkflow", "PowerShellWorkflow", "PowerShell", "Script"], var.runbook_type)
    error_message = "The type of the runbook can be either Graph, GraphPowerShell, GraphPowerShellWorkflow, PowerShellWorkflow, PowerShell or Script."
  }
}

variable "automation_account_name" {
  description = "(Required) Name of the related automation account"
  type        = string
}
