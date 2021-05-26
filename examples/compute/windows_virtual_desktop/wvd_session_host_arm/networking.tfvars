
# ## Networking configuration
vnets = {
  vnet_region1 = {
    resource_group_key = "wvd_region1"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.101.0/24"]
      dns_servers   = ["10.100.100.4"]
    }
    specialsubnets = {}

    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.101.0/25"]
        # nsg_key = "azure_wvd_nsg"
      }

    }

  }
}

# network_security_group_definition = {
#   # This entry is applied to all subnets with no NSG defined
#   empty_nsg = {}  
#   azure_wvd_nsg = {

#     nsg = [
#       {
#         name                       = "web-in-allow",
#         priority                   = "100"
#         direction                  = "Inbound"
#         access                     = "Allow"
#         protocol                   = "tcp"
#         source_port_range          = "*"
#         destination_port_range     = "443"
#         source_address_prefix      = "*"
#         destination_address_prefix = "*"
#       },      
#       {
#         name                       = "web-out-allow",
#         priority                   = "120"
#         direction                  = "Outbound"
#         access                     = "Allow"
#         protocol                   = "tcp"
#         source_port_range          = "*"
#         destination_port_range     = "443"
#         source_address_prefix      = "*"
#         destination_address_prefix = "AzureCloud"
#       }
#     ]
#   }
# }

