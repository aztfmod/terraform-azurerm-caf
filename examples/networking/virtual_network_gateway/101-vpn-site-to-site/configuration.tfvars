global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  vgnw = {
    name = "vgnw"
  }
}

vnets = {
  vnet_gw = {
    resource_group_key = "vgnw"
    vnet = {
      name          = "vgnw"
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
    resource_group_key = "vgnw"
    sku                = "Basic"
    # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    allocation_method = "Dynamic"
    # allocation method needs to be Dynamic
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }

  vngw_pip2 = {
    name               = "vngw_pip2"
    resource_group_key = "vgnw"
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
    name                       = "mygateway"
    resource_group_key         = "vgnw"
    type                       = "VPN"
    sku                        = "VpnGw1"
    private_ip_address_enabled = true
    # enable active_active only with VPN Type
    active_active = true
    # enable_bpg defaults to false. If set, true, input the necessary parameters as well. VPN Type only
    enable_bgp = true
    vpn_type   = "RouteBased"
    # multiple IP configs are needed for active_active state. VPN Type only.
    # do not create multiple IP configuration for ExpressRoute type.
    ip_configuration = {
      ipconfig1 = {
        ipconfig_name         = "gatewayIp1"
        public_ip_address_key = "vngw_pip"
        #lz_key                        = "examples"
        #lz_key optional, only needed if the vnet_key is inside another landing zone
        vnet_key                      = "vnet_gw"
        private_ip_address_allocation = "Dynamic"
      }
      ipconfig2 = {
        ipconfig_name         = "gatewayIp2"
        public_ip_address_key = "vngw_pip2"
        #lz_key                        = "examples"
        #lz_key optional, only needed if the vnet_key is inside another landing zone
        vnet_key                      = "vnet_gw"
        private_ip_address_allocation = "Dynamic"
      }
    }
    bgp_settings = {
      bpgsettings1 = {
        asn             = 65512
        peering_address = "10.0.0.5"
        peer_weight     = 0
      }
    }
  }
}