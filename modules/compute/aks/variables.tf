
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {}
variable "diagnostics" {}
variable "settings" {}
variable "subnets" {}
variable "resource_group" {}
variable "admin_group_object_ids" {}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
variable "diagnostic_profiles" {
  default = null
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
