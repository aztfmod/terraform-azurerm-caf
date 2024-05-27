global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  vpngw = {
    name = "example-vpn-gateway-connection"
  }
}

vnets = {
  vnet_vpn = {
    resource_group_key = "vpngw"
    vnet = {
      name          = "test-vpn"
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
    resource_group_key = "vpngw"
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
    resource_group_key         = "vpngw"
    type                       = "Vpn"
    sku                        = "VpnGw1"
    private_ip_address_enabled = true
    # enable_bpg defaults to false. If set, true, input the necessary parameters as well. VPN Type only
    enable_bgp = false
    vpn_type   = "RouteBased"
    # multiple IP configs are needed for active_active state. VPN Type only.
    ip_configuration = {
      ipconfig1 = {
        ipconfig_name         = "gatewayIp1"
        public_ip_address_key = "vngw_pip"
        #lz_key                        = "examples"
        #lz_key optional, only needed if the vnet_key is inside another landing zone
        vnet_key                      = "vnet_vpn"
        private_ip_address_allocation = "Dynamic"
      }
    }
  }
}

local_network_gateways = {
  local1 = {
    name               = "enterprisevpn"
    resource_group_key = "vpngw"
    address_space      = ["192.168.0.0/24"]
    gateway_address    = "1.1.1.1"
  }
}

virtual_network_gateway_connections = {
  connection1 = {
    name                        = "connection"
    resource_group_key          = "vpngw"
    type                        = "IPsec"
    region                      = "region1"
    virtual_network_gateway_key = "gateway1"
    local_network_gateway_key   = "local1"

    shared_key = "ie9p8y32r78eho'pmkl/dns3289ry"
  }

}

