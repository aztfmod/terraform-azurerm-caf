variable "settings" {
  description = "Configuration object for the Automation account Log Analytics Workspace link."
  # # optional fields supported after TF14
  # type = object({
  #   name                        = string
  #   resource_group_key          = string
  #   tags                        = optional(map(string))
  # })
}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}

variable "workspace_id" {
  description = "(Required) The Log Analytics Workspace id"
  type        = string
}

variable "read_access_id" {
  description = "(Optional) The ID of the readable Resource that will be linked to the workspace."
  type        = string
  default     = null
}

variable "write_access_id" {
  description = "(Optional) The ID of the writeable Resource that will be linked to the workspace."
  type        = string
  default     = null
}