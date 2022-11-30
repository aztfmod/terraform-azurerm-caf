variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = map(any)
  description = "Client configuration object (see module README.md)."
}
variable "resource_groups" {}
variable "private_endpoints" {}
variable "private_dns" {}
variable "remote_objects" {
  type = map(any)
}
variable "subnet_id" {}
variable "vnet_resource_group_name" {}
variable "vnet_location" {}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}