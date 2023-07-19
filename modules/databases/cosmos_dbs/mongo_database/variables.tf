variable "settings" {
  type = any
}

variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}

variable "cosmosdb_account_name" {
  type = any
}
