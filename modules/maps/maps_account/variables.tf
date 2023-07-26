variable "sku_name" {
  description = "(Required) The SKU of the Azure Maps Account. Possible values are S0, S1 and G2. Changing this forces a new resource to be created."
  type        = string
}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}
variable "resource_group_name" {
  description = "(Required) The name of the Resource Group in which the Azure Maps Account should exist. Changing this forces a new resource to be created."
  type        = string
}
variable "maps_account" {
  default     = {}
}
variable "maps" {
  default     = {}
}
variable "settings" {}