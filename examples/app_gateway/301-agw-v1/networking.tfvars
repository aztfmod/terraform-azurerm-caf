

vnets = {
  vnet_region1 = {
    resource_group_key = "agw_region1"
    vnet = {
      name          = "app_gateway_vnet"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      app-gateway-subnet = {
        name    = "app_gateway_subnet"
        cidr    = ["10.100.100.0/25"]
        nsg_key = "application_gateway"
      }
    }

  }
}

public_ip_addresses = {
  example_agw_pip1_rg1 = {
    name                    = "example_agw_pip1"
    resource_group_key      = "agw_region1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    availability_zone       = "1"
    idle_timeout_in_minutes = "4"

  }
}