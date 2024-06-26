variable "global_settings" {}
variable "settings" {}
variable "client_config" {}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "resource_group" {
  description = "Resource group object."
}

variable "namespace_name" {
  description = "Name of the notification hub namespace."
  type        = string
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}

variable "location" {
  description = "Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = null
}
variable "key_vault_id" {
  description = "The ID of the key vault where the secrets are stored."
  type        = string
}