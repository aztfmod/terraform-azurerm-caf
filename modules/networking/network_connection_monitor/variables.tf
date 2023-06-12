variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "name" {
  description = "(Required) Name of the IP Group to be created"
}

variable "tags" {
  description = "(Required) Tags of the IP Group to be created"
}

variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "location" {}

variable "network_watcher_name" {
  description = "Name of the resource_watcher ressource (optional)"
  type        = string
  default     = null
}
variable "network_watcher_resource_group_name" {
  description = "Name of the resource_watcher resource group (optional)"
  type        = string
  default     = null
}
variable "network_watcher_id" {
  description = "ID of the resource_watcher ressource (optional)"
  type        = string
  default     = null
}
variable "combined_objects_log_analytics" {}


variable "endpoint_objects" {
  description = "map of possible endpoint objects from caf"
  type        = map(any)
}


variable "settings" {}

variable "client_config" {}
