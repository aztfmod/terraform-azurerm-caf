variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  description = "Settings object (see module README.md)"
}

variable "vmware_cloud_id" {
  description = "The ID of the vmware private cloud"
  type        = string
}