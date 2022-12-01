variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type        = any
  description = "Settings object (see module README.md)."
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "tags" {
  type        = map(any)
  description = "(Required) map of tags for the deployment"
  default     = null
}
variable "location" {
  type        = string
  description = "(Required) Resource Location"
  default     = null
}
variable "resource_group_name" {
  type        = string
  description = "(Required) Resource group of the Logic App"
}
variable "integration_service_environment_id" {
  description = "(Optional) integration_service_environment_id"
  type        = string
  default     = null
}
variable "logic_app_integration_account_id" {
  description = "(Optional) logic_app_integration_account_id"
  type        = string
  default     = null
}



