variable "global_settings" {
  type        = any
  description = "Global settings object"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Action Group instance"
}

variable "settings" {
  type        = any
  description = "Configuration object for the monitor action group"
}
variable "remote_objects" {
  type        = any
  description = "Handle remote combined objects"
}
