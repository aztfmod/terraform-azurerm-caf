variable "global_settings" {
  description = "Global settings object"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Action Group instance"
  type        = string
}

variable "settings" {
  description = "Configuration object for the monitor action group"
}
variable "remote_objects" {
  description = "Handle remote combined objects"
}
