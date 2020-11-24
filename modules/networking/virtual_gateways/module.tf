resource "azurecaf_name" "vgw" {
  name          = var.name
  resource_type = "azurerm_firewall"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_virtual_network_gateway" "vgw" {
  name                = azurecaf_name.vgw.result
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type     = "Vpn"  
  sku           = "Basic"
  active_active = false

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = var.public_ip_address_id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.subnet_id
  }


#### In development. VPN Type will be coming soon ####
#   enable_bgp    = false
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