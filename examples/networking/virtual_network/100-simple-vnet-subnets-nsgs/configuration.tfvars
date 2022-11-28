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
      #dns_servers   = ["10.2.0.5", "10.2.0.6"]
      # dns_servers_keys = {
      #   ip1 = {
      #     lz_key          = "" # must be in a remote deployment, no uncomment
      #     key             = ""
      # .   resource_type   = "azurerm_firewall"
      #     interface_index = 0 #Optional it will take 0.
      #
      #   }
      #   ip2 = {
      #     lz_key          = "" # must be in a remote deployment, no uncomment
      #     key             = ""
      #     resource_type   = "azurerm_firewall"
      #   }
      # }
    }
    specialsubnets = {}
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
        name    = "data-layer"
        cidr    = ["10.1.4.0/24"]
        nsg_key = "data"
      }
    }
  }
}