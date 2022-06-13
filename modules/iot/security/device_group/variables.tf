variable "settings" {}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "iothub_id" {
  description = "(Required) The id of the IoT Hub. Changing this forces a new resource to be created"
}
