network_security_group_definition = {

  jump_host = {

    nsg = [
      {
        name                       = "winrm",
        priority                   = "200"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5985"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "winrms",
        priority                   = "201"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5986"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "rdp-inbound-3389",
        priority                   = "210"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "VirtualNetwork"
      },
    ]
  }

  web = {

    nsg = [
      {
        name                       = "web-inbound-http",
        priority                   = "103"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "web-inbound-https",
        priority                   = "104"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "web-from-jump-host",
        priority                   = "105"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "10.1.1.0/24"
        destination_address_prefix = "VirtualNetwork"
      },
    ]
  }

  app = {

    nsg = [
      {
        name                       = "app-inbound",
        priority                   = "103"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "8443"
        source_address_prefix      = "10.2.1.0/24"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "app-from-jump-host",
        priority                   = "104"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "10.1.1.0/24"
        destination_address_prefix = "VirtualNetwork"
      },
    ]
  }

  data = {

    nsg = [
      {
        name                       = "data-inbound",
        priority                   = "103"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5233"
        source_address_prefix      = "10.3.1.0/24"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "data-from-jump-host",
        priority                   = "104"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "10.1.1.0/24"
        destination_address_prefix = "VirtualNetwork"
      },
    ]
  }
}