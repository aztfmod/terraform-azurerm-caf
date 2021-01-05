module "caf" {
  source = "../../../../../../caf"
  global_settings    = var.global_settings
  resource_groups  = var.resource_groups
  tags               = var.tags
  networking = {
    vnets  = var.vnets
    public_ip_addresses          = var.public_ip_addresses 
    virtual_network_gateways  = var.virtual_network_gateways
    local_network_gateways  = var.local_network_gateways
    virtual_network_gateway_connections = var.virtual_network_gateway_connections

  }
}
  
