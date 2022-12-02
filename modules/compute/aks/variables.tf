
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type = any
}
variable "diagnostics" {
  type = any
}
variable "settings" {
  type = any
}
variable "location" {
  type = string
}
variable "vnets" {
  type = any
}
variable "resource_group_name" {
  type = string
}
variable "admin_group_object_ids" {
  type = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = any
}
variable "diagnostic_profiles" {
  type    = any
  default = {}
}
variable "private_dns_zone_id" {
  type    = any
  default = null
}
variable "managed_identities" {
  type    = any
  default = {}
}
variable "application_gateway" {
  type    = any
  default = {}
}
