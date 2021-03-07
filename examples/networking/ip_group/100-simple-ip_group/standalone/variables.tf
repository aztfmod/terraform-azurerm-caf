variable "global_settings" {
  default = {}
}

variable "resource_groups" {
  default = null
}

variable "vnets" {
  default = {}
}

variable "tags" {
  default = null
  type    = map(any)
}

variable "public_ip_addresses" {
  default = {}
}

variable "azurerm_firewalls" {
  default = {}
}

variable "var_folder_path" {
  default = {}
}

variable "ip_groups" {
  default = {}
}
