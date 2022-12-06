variable "client_config" {
  type = any
}
variable "settings" {
  type = any
}
variable "virtual_hub_route_tables" {
  type    = any
  default = {}
}
variable "authorization_key" {
  type    = any
  default = null
}
variable "express_route_circuit_peering_id" {
  type = any
}
variable "express_route_gateway_id" {
  type = any
}
variable "virtual_hub_id" {
  type = any
}