vnets = {
  vnet_hub_re1 = {
    resource_group_key = "hub_re1"
    region             = "region1"
    vnet = {
      name          = "vnet_hub_re1"
      address_space = ["100.64.100.0/22"]
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["100.64.101.0/26"]
      }
    }
    subnets = {}
  }
  vnet_spoke_re1 = {
    resource_group_key = "spoke_re1"
    region             = "region1"
    vnet = {
      name          = "vnet_spoke_re1"
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
