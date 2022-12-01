variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "diagnostics" {
  type = map(any)
}
variable "front_door_waf_policies" {
  default = {}
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "keyvault_id" {
  default = null
}
variable "keyvault_certificate_requests" {
  default = {}
}
variable "keyvaults" {
  type    = map(any)
  default = {}
}
variable "resource_group_name" {
  type = string
}
variable "settings" {
  type = any
}
variable "tags" {
  type    = map(any)
  default = {}
}

