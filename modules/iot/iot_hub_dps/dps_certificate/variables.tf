variable "settings" {}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "resource_group_name" {
  description = "(Required) Resource group"
}

variable "iot_dps_name" {
  description = "(Required) The name of the IoT Hub. Changing this forces a new resource to be created"
}
