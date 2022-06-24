variable "settings" {
  description = "Configuration object for the Automation account."
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
  description = "(Required) Read access id"
  type        = string
}