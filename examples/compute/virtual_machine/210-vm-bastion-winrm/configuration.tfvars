
global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
  inherit_tags = true
  tags = {
    example = "compute/virtual_machine/210-vm-bastion-winrm"
  }
}

resource_groups = {
  vm_region1 = {
    name = "example-virtual-machine-rg1"
    tags = {
      rg_key = "vm_region1"
    }
  }
  nsg_region1 = {
    name = "example-virtual-machine-nsg-rg1"
  }
}



