variable "name" {
  type = string
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "route_table_name" {}
variable "address_prefix" {}
variable "next_hop_type" {}
variable "next_hop_in_ip_address_fw" {
  default = null
}
variable "next_hop_in_ip_address_vm" {
  default = null
}
variable "next_hop_in_ip_address" {
  default = null
}