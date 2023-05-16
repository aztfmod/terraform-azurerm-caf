variable "resource_id" {
  type = any
}

variable "name" {
  type        = string
  description = "(Required) Specifies the name. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group. Changing this forces a new resource to be created."
  default     = null
}
variable "resource_groups" {
  type        = any
  description = "The combined_objects of the resource groups. Changing this forces a new resource to be created."
  default     = {}
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  default     = null
}

variable "subnet_id" {
  type = string
}
variable "settings" {
  type = any
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "subresource_names" {
  type    = any
  default = []
}
variable "client_config" {
  type    = any
  default = {}
}
variable "private_dns" {
  type    = any
  default = {}
}
variable "tags" {
  type    = any
  default = {}
}
