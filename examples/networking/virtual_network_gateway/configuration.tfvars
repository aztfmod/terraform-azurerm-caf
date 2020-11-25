global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}
resource_groups = {
  er = {
    name = "example-express-route-re1"
  }
}


vnets = {
  vnet_spoke_data_re1 = {
    resource_group_key = "vnet_re1"
    vnet = {
      name          = "test-vn"
      address_space = ["10.150.100.0/24"]
    }
    specialsubnets = {
      GatewaySubnet = {
        name = "GatewaySubnet"  # must be named GatewaySubnet
      }
    subnets = {} 
    }
  }

public_ip_addresses = {
  vngw = {
    name                    = "vngw_pip1"
    resource_group_key      = "er"
    sku                     = "Standard"  
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}

virtual_network_gateways = {
  gateway1 = {
  name = "mygateway"
  resource_group_key = "er"
  public_ip_key = "vngw"
  #supports only ExpressRoute at this time. VPN type is coming soon
  type = "ExpressRoute" 
  sku = "Standard"
  # enable active_active only with UltraPerformance and HighPerformance SKUs
  active_active = false  
  enable_bgp = false 
  ip_config_name = "gatewayIp"
  # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    }
  }