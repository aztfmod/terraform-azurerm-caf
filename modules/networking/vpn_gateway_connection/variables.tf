variable "settings" {
  type = any
}
variable "global_settings" {
  type        = any
  description = "Global settings object (see module README.md)"
}
variable "vpn_gateway_id" {}
variable "vpn_sites" {}
variable "client_config" {
  type = map(any)
}
variable "route_tables" {}
