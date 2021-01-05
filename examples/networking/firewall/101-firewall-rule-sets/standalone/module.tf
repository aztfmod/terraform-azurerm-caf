module "caf" {
  source = "../../../../../../caf"
  global_settings    = var.global_settings
  resource_groups = var.resource_groups
  tags               = var.tags
  networking = {
    vnets  = var.vnets
    public_ip_addresses          = var.public_ip_addresses 
    azurerm_firewalls  = var.azurerm_firewalls 
    route_tables  = var.route_tables
    azurerm_routes = var.azurerm_routes
    azurerm_firewall_network_rule_collection_definition  = var.azurerm_firewall_network_rule_collection_definition
    azurerm_firewall_application_rule_collection_definition = var.azurerm_firewall_application_rule_collection_definition

  }
}
  
