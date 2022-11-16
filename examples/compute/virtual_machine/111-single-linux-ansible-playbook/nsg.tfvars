network_security_group_definition = {

  open_remote = {

    nsg = [
      {
        name                       = "ssh-inbound-22",
        priority                   = "211"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "Internet"
        destination_address_prefix = "VirtualNetwork"
      },
    ]
  }
}