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

variable "azurerm_firewall_application_rule_collection_definition" {
  default = {}
}

variable "azurerm_firewall_network_rule_collection_definition" {
  default = {}
}

variable "azurerm_firewall_nat_rule_collection_definition" {
  default = {}
}
