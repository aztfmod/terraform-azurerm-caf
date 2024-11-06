variable "settings" {}
variable "resource_groups" {}
variable "resource_group_name" {
  description = "(Required) The name of the resource group where to create the resource."
  type        = string
}
variable "location" {
  description = "(Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created."
  type        = string
}
variable "diagnostics" {}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = map(any)
}

variable "virtual_networks" {
  description = "Combined object for Virtual Networks"
}
variable "public_ip_addresses" {
  description = "Combined object for public ip addresses"
}
variable "keyvaults" {
  description = "Combined object for keyvaults"
}
variable "client_config" {

}
