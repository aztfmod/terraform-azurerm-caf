variable "client_config" {
  type = map(any)
}
variable "virtual_hub_route_tables" {
  default = {}
}
variable "authorization_key" {}
variable "express_route_circuit_id" {}
variable "express_route_gateway_name" {}
variable "location" {}
variable "resource_group_name" {
  type = string
}
variable "settings" {
  type = any
}
variable "virtual_hub_id" {}
variable "virtual_network_gateway_id" {}
