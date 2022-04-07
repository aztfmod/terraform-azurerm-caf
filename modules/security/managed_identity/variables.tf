variable "client_config" {
  description = "Client configuration object"
}
variable "name" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "resource_groups" {
  description = "Combined object of local and remote resource groups."
}
variable "settings" {}
variable "tags" {
  default = null
}
