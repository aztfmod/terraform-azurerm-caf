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
variable "vnets" {
  type = any
}
variable "admin_group_object_ids" {
  type = any
}
variable "location" {
  description = "location of the resource if different from the resource group."
  type        = string
  default     = null
}
variable "resource_group_name" {
  description = "Resource group object to deploy the virtual machine"
  type        = string
  default     = null
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
  type        = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
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
variable "private_endpoints" {
  default = {}
}
variable "private_dns" {
  default = {}
}
