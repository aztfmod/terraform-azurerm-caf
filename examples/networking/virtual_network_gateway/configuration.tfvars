global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}
resource_groups = {
  vm_region1 = {
    name = "example-express-route-re1"
  }
}


vnets = {
  vnet_spoke_data_re1 = {
    resource_group_key = "vnet_re1"
    vnet = {
      name          = "databricks"
      address_space = ["10.150.100.0/24"]
    }
    specialsubnets = {}
    subnets = {} 
    }
  }

virtual_network_gateways = {
  name = "mygateway"
  #supports only ExpressRoute at this time. VPN type is coming soon
  type = "ExpressRoute" 
  sku = "Standard"
  # enable active_active only with UltraPerformance and HighPerformance SKUs
  active_active = false  
  enable_bgp = false 
  ip_config_name = "gatewayIp"
  # Note: For UltraPerformance ExpressRoute Virtual Network gateway, the associated Public IP needs to be sku "Basic" not "Standard"
    