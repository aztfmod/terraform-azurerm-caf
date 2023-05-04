network_security_group_definition = {
  # directly exposing RDP incoming traffic to Internet
  # this setup makes it easy to RDP into the VMs after deploying this example
  # this is NOT recommend in a real environment (use Azure Bastion)
  rdp_for_all = {
    nsg = [
      {
        name                       = "rdp-inbound-3389",
        priority                   = "101"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        destination_port_range     = "3389"
      },
    ]
  }
}
# basic vnet that VMs connect to
vnets = {
  vnet1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "vnet1"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      default = {
        name    = "default"
        cidr    = ["10.100.100.0/29"]
        nsg_key = "rdp_for_all"
      }
    }
  }
}
# public ip to access VMs through
public_ip_addresses = {
  pip1 = {
    name                    = "pip1"
    resource_group_key      = "rg1"
    sku                     = "Basic"
    allocation_method       = "Dynamic"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}