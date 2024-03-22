variable "global_settings" {}
variable "settings" {}
variable "client_config" {}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
  default     = null
}

variable "notification_hub_name" {
  description = "The name of the Notification Hub for which the Authorization Rule should be created."
  type        = string
}

variable "namespace_name" {
  description = "Name of the notification hub namespace."
  type        = string
}
