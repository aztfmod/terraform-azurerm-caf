variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  type        = any
  description = "Client configuration object (see module README.md)."
}
variable "resource_groups" {
  type = any
}
variable "private_endpoints" {
  type = any
}
variable "private_dns" {
  type = any
}
variable "remote_objects" {
  type = any
}
variable "subnet_id" {
  type = string
}
variable "vnet_resource_group_name" {
  type = any
}
variable "vnet_location" {
  type = any
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}
