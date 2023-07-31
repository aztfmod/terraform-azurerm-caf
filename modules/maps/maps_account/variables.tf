variable "sku_name" {
  description = "(Required) The SKU of the Azure Maps Account. Possible values are S0, S1 and G2. Changing this forces a new resource to be created."
  type        = string
}
variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "resource_group" {
  default = {}
}
variable "resource_group_name" {
  type        = string
}
variable "maps_accounts" {
  default     = {}
}
variable "maps" {
  default     = {}
}
variable "settings" {}
# variable "tags" {
#   description = "(Required) Map of tags to be applied to the resource"
#   type        = map(any)
# }
variable "remote_objects" {
  default = {}
}
variable "base_tags" {
  description = "Base tags for the resource to be inherited from the resource group."
  type        = bool
}