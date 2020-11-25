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
  active_active = var.settings.active_active
  enable_bgp    = var.settings.enable_bgp

  dynamic "bgp_settings" {
    for_each = try(var.settings.bgp_settings, {})
    content {
      asn = each.value.asn
      peering_address = each.value.peering_address 
      peer_weight = each.value.peer_weight
    }
  }
  
  ip_configuration {
    name                          = var.settings.ip_config_name
    public_ip_address_id          = var.public_ip_id
    private_ip_address_allocation = var.settings.private_ip_address_allocation
    subnet_id                     = var.subnet_id
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