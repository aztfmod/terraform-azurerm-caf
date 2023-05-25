variable "settings" {}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
}

variable "resource_group_name" {
  description = "(Required) Resource group of the IoT Hub"
}

variable "resource_group" {
  description = "Resource group object to deploy the IoT Hub"
}

variable "location" {
  description = "(Required) Region in which the resource will be deployed"
}

variable "remote_objects" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  default     = {}
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
