variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "diagnostics" {
  type = any
}
variable "front_door_waf_policies" {
  type    = any
  default = {}
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "keyvault_id" {
  type    = string
  default = null
}
variable "keyvault_certificate_requests" {
  type    = any
  default = {}
}
variable "keyvaults" {
  type    = any
  default = {}
}
variable "resource_group_name" {
  type = string
}
variable "settings" {
  type = any
}
variable "tags" {
  type    = any
  default = {}
}

