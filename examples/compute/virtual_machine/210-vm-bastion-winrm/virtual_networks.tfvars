vnets = {
  vnet_region1 = {
    resource_group_key = "vm_region1"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      bastion = {
        name    = "bastion"
        cidr    = ["10.100.100.0/25"]
        nsg_key = "bastion_ssh"
      }
      servers = {
        name    = "servers"
        cidr    = ["10.100.100.128/25"]
        nsg_key = "windows_server"
      }
    }
  }
}