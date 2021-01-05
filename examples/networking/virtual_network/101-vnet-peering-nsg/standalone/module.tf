module "caf" {
  source = "../../../../../../caf"
  global_settings    = var.global_settings
  resource_groups  = var.resource_groups
  tags               = var.tags
  networking = {
    vnets  = var.vnets
    vnet_peerings = var.vnet_peerings 
    public_ip_addresses          = var.public_ip_addresses 
    route_tables  = var.route_tables
    azurerm_routes = var.azurerm_routes
    network_security_group_definition = var.network_security_group_definition 
  }
}
  
