global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  hub_re1 = {
    name   = "vnet-hub-re1"
    region = "region1"
  }
}

virtual_wans = {
  vwan_re1 = {
    resource_group_key = "hub_re1"
    name               = "contosovWAN-re1"
    region             = "region1"

    hubs = {
      hub_re1 = {
        hub_name           = "hub-re1"
        region             = "region1"
        hub_address_prefix = "10.0.3.0/24"
        deploy_firewall    = false
        deploy_p2s         = false
        p2s_config         = {}
        deploy_s2s         = false
        s2s_config         = {}
        deploy_er          = false
        er_config          = {}
        hub_ip = {
          ip1 = {
            name                         = "example-vhubipconfig"
            private_ip_address           = "10.100.100.4"
            private_ip_allocation_method = "Static"
            public_ip_address = {
              public_ip_address_key = "vwan_pip1"
              #lz_key = "lz_key"
            }
            subnet = {
              vnet_key   = "vnet_region1"
              subnet_key = "RouteServerSubnet"
              #lz_key = "lz_key"
            }
            # We can also directly provide the resource ID
            # public_ip_address_id         = "Azure_Resource_ID"
            # subnet_id                    = "Azure_Resource_ID"
          }
        }
      }
    }
  }
}

public_ip_addresses = {
  vwan_pip1 = {
    name               = "vwan_pip1"
    resource_group_key = "hub_re1"
    sku                = "Standard"
    allocation_method  = "Static"
    ip_version         = "IPv4"
  }
}

vnets = {
  vnet_region1 = {
    resource_group_key = "hub_re1"
    vnet = {
      name          = "vwan_demo"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {
      RouteServerSubnet = {
        name = "RouteServerSubnet"
        cidr = ["10.100.100.0/27"]
      }
    }
    subnets = {

    }

  }
}


virtual_hub_connections = {

  # Establish the peering with Virtual Hubs

  con1 = {
    name                      = "vnet1-con1"
    internet_security_enabled = true

    vhub = {
      virtual_wan_key = "vwan_re1"
      virtual_hub_key = "hub_re1"
    }

    vnet = {
      # If the virtual network is stored in another another landing zone, use the following attributes to refer the state file:
      vnet_key = "vnet_region1"
    }

  }


}

