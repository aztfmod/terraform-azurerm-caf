variable "azure_firewall_name" {
  description = "(Required) Specifies the name of the Firewall in which the Network Rule Collection should be created. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the Resource Group in which the Firewall exists. Changing this forces a new resource to be created."
}

variable "rule_collections" {
  description = "(Required) One or more rules as defined https://www.terraform.io/docs/providers/azurerm/r/firewall_nat_rule_collection.html"
}

variable "azurerm_firewall_nat_rule_collection_definition" {}

variable "global_settings" {
  description = "Global settings object (see module README.md)"
}

variable "ip_groups" {
  default = {}
}

variable "public_ip_addresses" {
  default = {}
}
