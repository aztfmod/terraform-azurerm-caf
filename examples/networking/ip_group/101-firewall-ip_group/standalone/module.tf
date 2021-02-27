module "caf" {
  source          = "../../../../../"
  global_settings = var.global_settings
  resource_groups = var.resource_groups
  tags            = var.tags
  networking = {
    vnets                                                   = var.vnets
    public_ip_addresses                                     = var.public_ip_addresses
    azurerm_firewalls                                       = var.azurerm_firewalls
    vnets                                                   = var.vnets
    ip_groups                                               = var.ip_groups
    azurerm_firewalls                                       = var.azurerm_firewalls
    azurerm_firewall_application_rule_collection_definition = var.azurerm_firewall_application_rule_collection_definition
    azurerm_firewall_network_rule_collection_definition     = var.azurerm_firewall_network_rule_collection_definition
    azurerm_firewall_nat_rule_collection_definition         = var.azurerm_firewall_nat_rule_collection_definition
  }
}

