application_security_groups = {
  bastion = {
    name               = "bastionappsecgw1"
    resource_group_key = "vm_region1"

  }

  app_server = {
    name               = "appserverappsecgw1"
    resource_group_key = "vm_region1"

  }
}


network_security_group_definition = {

  data = {

    version            = 1
    resource_group_key = "nsg_region1"
    name               = "data"

    nsg = [
      {
        name                       = "data-inbound",
        priority                   = "103"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5233"
        source_address_prefix      = "10.0.1.0/24"
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

  windows_server = {

    nsg = [
      {
        name                   = "winrm",
        priority               = "200"
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "tcp"
        source_port_range      = "*"
        destination_port_range = "5985"
        source_application_security_groups = {
          keys = ["bastion"]
        }
        destination_application_security_groups = {
          keys = ["app_server"]
        }
      },
      {
        name                   = "winrms",
        priority               = "201"
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "tcp"
        source_port_range      = "*"
        destination_port_range = "5986"
        source_application_security_groups = {
          keys = ["bastion"]
        }
        destination_application_security_groups = {
          keys = ["app_server"]
        }
      },
      {
        name                   = "rdp-inbound-3389",
        priority               = "210"
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "tcp"
        source_port_range      = "*"
        destination_port_range = "3389"
        source_application_security_groups = {
          keys = ["bastion"]
        }
        destination_application_security_groups = {
          keys = ["app_server"]
        }
      },
    ]
  }

  bastion_ssh = {

    nsg = [
      {
        name                   = "bastion-vnet-out-allow-22",
        priority               = "103"
        direction              = "Outbound"
        access                 = "Allow"
        protocol               = "tcp"
        source_port_range      = "*"
        destination_port_range = "22"
        source_application_security_groups = {
          keys = ["bastion"]
        }
        destination_application_security_groups = {
          keys = ["app_server"]
        }
      },
    ]
  }

}