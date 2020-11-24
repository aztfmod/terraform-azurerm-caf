

resource "azurerm_virtual_network_gateway" "vgw" {
  name                = "test"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type     = "Vpn"  
  sku           = "Basic"
  active_active = false

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.example.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.example.id
  }


#### in development ####
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