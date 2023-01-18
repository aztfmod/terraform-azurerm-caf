variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "client_config" {
  description = "Client configuration object (see module README.md)."
}
variable "settings" {
  description = "Settings object (see module README.md)."
}
variable "resource_groups" {
  description = "Resource Groups"
}
variable "storage_accounts" {
  description = "Storage Accounts"
}
variable "app_service_plans" {
  description = "App Service Plans"
}
variable "app_settings" {
  description = "Application settings"
}
variable "subnets" {
  description = "Subnets"
}
variable "private_endpoints" {
  default = {}
}
variable "private_dns" {
  default = {}
}
variable "vnets" {
  default = {}
}
variable "base_tags" {
  default = {}
}
variable "identity" {
  default = null
}
variable "combined_objects" {
  default = {}
}
variable "virtual_subnets" {
  default = {}
}
variable "vnet_integration" {
  default = {}
}