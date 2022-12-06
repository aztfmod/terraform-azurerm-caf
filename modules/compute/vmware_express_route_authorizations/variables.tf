variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  type        = any
  description = "Settings object (see module README.md)"
}

variable "vmware_cloud_id" {
  description = "The ID of the vmware private cloud"
  type        = string
}