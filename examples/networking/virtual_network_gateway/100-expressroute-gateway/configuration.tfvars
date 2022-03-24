global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  er = {
    name = "example-express-route-re1"
  }
}

vnets = {
  vnet_er = {
    resource_group_key = "er"
    vnet = {
      name          = "test-vn"
      address_space = ["10.2.0.0/16"]
    }
    specialsubnets = {
      GatewaySubnet = {
        name = "GatewaySubnet" # must be named GatewaySubnet
        cidr = ["10.2.1.0/24"]
      }
    }
    subnets = {}
  }
}

public_ip_addresses = {
  vngw_pip = {
    name               = "vngw_pip1"
    resource_group_key = "er"
    sku                = "Basic"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Dynamic"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

virtual_network_gateways = {
  gateway1 = {
    name               = "mygateway"
    resource_group_key = "er"
    type               = "ExpressRoute"
    sku                = "Standard"
    # enable active_active only with VPN Type
    active_active = false
    # enable_bpg defaults to false. If set, true, input the necessary parameters as well. VPN Type only
    enable_bgp = false
    # multiple IP configs are needed for active_active state. VPN Type only.
    # do not create multiple IP configuration for ExpressRoute type.
    ip_configuration = {
      ipconfig1 = {
        ipconfig_name         = "gatewayIp"
        public_ip_address_key = "vngw_pip"
        #lz_key = "examples"
        vnet_key                      = "vnet_er"
        private_ip_address_allocation = "Dynamic"
      }
    }
  }
}