vnets = {
  vnet_ip_group_re1 = {
    resource_group_key = "ip_group_re1"
    region             = "region1"
    vnet = {
      name          = "vnet_ip_group_re1"
      address_space = ["10.100.80.0/22"]
    }
    subnets = {
      subnet1 = {
        name = "subnet1"
        cidr = ["10.100.81.0/24"]
      }
      subnet2 = {
        name = "subnet2"
        cidr = ["10.100.82.0/24"]
      }
    } //subnets

    specialsubnets = {}

  }
} //vnets
