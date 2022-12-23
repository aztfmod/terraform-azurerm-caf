variable "name" {
  type = string
}
variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group where to create the resource."
}
variable "route_table_name" {
  type = any
}
variable "address_prefix" {
  type = any
}
variable "next_hop_type" {
  type = any
}
variable "next_hop_in_ip_address_fw" {
  type    = any
  default = null
}
variable "next_hop_in_ip_address_vm" {
  type    = any
  default = null
}
variable "next_hop_in_ip_address" {
  type    = any
  default = null
}
