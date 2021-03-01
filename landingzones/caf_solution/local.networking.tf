locals {
  networking = {
    application_gateway_applications     = var.application_gateway_applications
    application_gateways                 = var.application_gateways
    azurerm_routes                       = var.azurerm_routes
    dns_zones                            = var.dns_zones
    dns_zone_records                     = var.dns_zone_records
    domain_name_registrations            = var.domain_name_registrations
    express_route_circuit_authorizations = var.express_route_circuit_authorizations
    express_route_circuits               = var.express_route_circuits
    front_door_waf_policies              = var.front_door_waf_policies
    front_doors                          = var.front_doors
    local_network_gateways               = var.local_network_gateways
    network_security_group_definition    = var.network_security_group_definition
    network_watchers                     = var.network_watchers
    private_dns                          = var.private_dns
    private_endpoints                    = var.private_endpoints
    public_ip_addresses                  = var.public_ip_addresses
    route_tables                         = var.route_tables
    virtual_network_gateway_connections  = var.virtual_network_gateway_connections
    virtual_network_gateways             = var.virtual_network_gateways
    virtual_wans                         = var.virtual_wans
    vnet_peerings                        = var.vnet_peerings
    vnets                                = var.vnets
  }
}