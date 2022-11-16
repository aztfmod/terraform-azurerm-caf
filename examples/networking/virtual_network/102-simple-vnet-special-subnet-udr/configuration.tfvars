global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  network = {
    name   = "vnet"
    region = "region1"
  }
}


vnets = {
  vnet1 = {
    resource_group_key = "network"
    vnet = {
      name          = "app-vnet"
      address_space = ["10.1.0.0/16"]
    }
    specialsubnets = {
      gateway_subnet = {
        name            = "GatewaySubnet"
        cidr            = ["10.1.5.0/24"]
        route_table_key = "special_rt"
      }
      azure_firewall_subnet = {
        name = "AzureFirewallSubnet"
        cidr = ["10.1.6.0/24"]
      }
    }
    subnets = {
      jump_host = {
        name    = "jump_host"
        cidr    = ["10.1.1.0/24"]
        nsg_key = "jump_host"
      }
      web = {
        name    = "web-layer"
        cidr    = ["10.1.2.0/24"]
        nsg_key = "web"
      }
      app = {
        name    = "app-layer"
        cidr    = ["10.1.3.0/24"]
        nsg_key = "app"
      }
      data = {
        name            = "data-layer"
        cidr            = ["10.1.4.0/24"]
        nsg_key         = "data"
        route_table_key = "no_internet"
      }
    }
  }
}