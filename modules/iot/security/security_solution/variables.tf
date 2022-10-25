variable "settings" {}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "location" {
  description = "(Required) Region in which the resource will be deployed"
}

variable "resource_group_name" {
  description = "(Required) Resource group of the App Service"
}

variable "iothub_ids" {
  description = "(Required) Specifies the IoT Hub resource IDs to which this Iot Security Solution is applied."
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
  default     = {}
}