variable "prefix" {
  description = "(Optional) Prefix to uniquely identify the deployment"
  type        = string
  default     = ""
}

variable "global_settings" {
  description = "global settings"
}

variable "virtual_hub_config" {
  description = "core_networking"
}

variable "location" {
  description = "(Required) Location where to create the hub resources"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Name of the resource group to create the hub resources"
  type        = string
}


# variable "firewall_resource_group_name" {
#   description = "(Required) Name of the resource group for Azure Firewall"
#   type        = string
# }


variable "vwan_id" {
  description = "(optional) Resource ID for the Virtual WAN object"
  type        = string
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "virtual_networks" {
  description = "Combined object for Virtual Networks"
}
variable "public_ip_addresses" {
  description = "Combined object for public ip addresses"
}
variable "client_config" {

}