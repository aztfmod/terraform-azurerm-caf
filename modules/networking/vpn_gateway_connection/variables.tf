variable "settings" {
  type = any
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "vpn_gateway_id" {
  type = any
}
variable "vpn_sites" {
  type = any
}
variable "client_config" {
  type = any
}
variable "route_tables" {
  type = any
}
