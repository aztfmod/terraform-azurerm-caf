resource "azurecaf_name" "vgw" {
  name          = var.settings.name
  resource_type = "azurerm_virtual_network_gateway"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_virtual_network_gateway" "vngw" {
  name                = azurecaf_name.vgw.result
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = var.settings.type 
  sku           = var.settings.sku
  active_active = try(var.settings.active_active, null)
  enable_bgp    = try(var.settings.enable_bgp, null)

  dynamic "bgp_settings" {
    for_each = try(var.settings.bgp_settings, {})
    content {
      asn = each.value.asn
      peering_address = each.value.peering_address 
      peer_weight = each.value.peer_weight
    }
  }
  
  dynamic "ip_configuration" {
    for_each = try(var.settings.ip_configuration, {})
    content {
    name                          = ip_configuration.value.ipconfig_name
    public_ip_address_id          = try(var.public_ip_addresses[ip_configuration.value.public_ip_address_key].id, null)
    private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
    subnet_id                  = try(var.vnets[var.client_config.landingzone_key][ip_configuration.value.vnet_key].subnets["GatewaySubnet"].id, var.vnets[ip_configuration.lz_key][ip_configuration.value.vnet_key].subnets["GatewaySubnet"].id)
    }
  }


  timeouts {
    create = "60m"
    delete = "60m"
  }
  
  tags = var.tags

}
#### In development. VPN Type will be supported soon ####
#   
#   vpn_type = " "
#   vpn_client_configuration {
#     address_space = [" "]
#     root_certificate {
#       name = " "
#       public_cert_data = <<EOF
#       EOF
#     }
#     revoked_certificate {
#       name       = " "
#       thumbprint = " "
#     }
#   }
# }