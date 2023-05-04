variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {}
variable "diagnostics" {}
variable "settings" {}
variable "vnets" {}
variable "admin_group_object_ids" {}
variable "location" {
  description = "location of the resource if different from the resource group."
  default     = null
}
variable "resource_group_name" {
  description = "Resource group object to deploy the virtual machine"
  default     = null
}
variable "resource_group" {
  description = "Resource group object to deploy the virtual machine"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}
variable "diagnostic_profiles" {
  default = {}
}
variable "private_dns_zone_id" {
  default = null
}
variable "managed_identities" {
  default = {}
}
variable "application_gateway" {
  default = {}
}
variable "private_endpoints" {
  default = {}
}
variable "private_dns" {
  default = {}
}