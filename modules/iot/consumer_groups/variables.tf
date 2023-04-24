variable "settings" {}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "resource_group_name" {
  description = "(Required) Resource group of the App Service"
}

variable "resource_group" {
  description = "Resource group object to deploy the IoT Hub consumper groups"
}

variable "iothub_name" {
  description = "(Required) The name of the IoT Hub. Changing this forces a new resource to be created"
}
