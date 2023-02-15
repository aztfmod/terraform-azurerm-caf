variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "automation_account_name" {}

variable "frequency" {
  description = "(Required) Frequency of the schedule"
  type        = string

  validation {
    condition     = contains(["OneTime", "Day", "Hour", "Week", "Month"], var.frequency)
    error_message = "The Frequency can be either OneTime, Day, Hour, Week, or Month."
  }
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "settings" {
  description = "Configuration object for the Automation account schedule."
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}


variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "remote_objects" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}

variable "client_config" {}
