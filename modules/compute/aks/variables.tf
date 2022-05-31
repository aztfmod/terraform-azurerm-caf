
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {}
variable "diagnostics" {}
variable "settings" {}
variable "location" {}
variable "vnets" {}
variable "resource_group_name" {}
variable "admin_group_object_ids" {}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
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
